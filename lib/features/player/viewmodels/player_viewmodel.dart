import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/constants/soundscape_presets.dart';
import '../../../core/services/audio_engine_service.dart';
import '../../../core/services/storage_service.dart';
import '../models/soundscape.dart';
import '../models/soundscape_mode.dart';

class PlayerViewModel extends ChangeNotifier {
  final AudioEngineService audioService;
  final StorageService storageService;

  late SoundscapeMode _selectedMode;
  late Soundscape _currentSoundscape;
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _binauralEnabled = true;
  String? _errorMessage;

  double _volume = 0.8;
  double _intensity = 0.75;

  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<Soundscape?>? _soundscapeSub;

  PlayerViewModel({
    required this.audioService,
    required this.storageService,
  }) {
    _init();
  }

  // Getters
  SoundscapeMode get selectedMode => _selectedMode;
  Soundscape get currentSoundscape => _currentSoundscape;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  bool get binauralEnabled => _binauralEnabled;
  double get volume => _volume;
  double get intensity => _intensity;
  String? get errorMessage => _errorMessage;

  List<Soundscape> get currentModePresets =>
      SoundscapePresets.getByMode(_selectedMode);

  void _init() {
    // Restore saved settings
    _volume = storageService.getMasterVolume();
    _intensity = storageService.getIntensity();
    _binauralEnabled = storageService.getBinauralEnabled();

    final lastId = storageService.getLastSoundscapeId();
    final savedSoundscape = SoundscapePresets.all.firstWhere(
      (s) => s.id == lastId,
      orElse: () => SoundscapePresets.defaultSoundscape,
    );

    _currentSoundscape = savedSoundscape;
    _selectedMode = savedSoundscape.mode;

    // Listen to player state
    _playerStateSub = audioService.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _isLoading = state.processingState == ProcessingState.buffering ||
          state.processingState == ProcessingState.loading;
      notifyListeners();
    });

    _soundscapeSub = audioService.currentSoundscapeStream.listen((soundscape) {
      if (soundscape != null && soundscape.id != _currentSoundscape.id) {
        _currentSoundscape = soundscape;
        _selectedMode = soundscape.mode;
        notifyListeners();
      }
    });
  }

  void selectMode(SoundscapeMode mode) {
    if (_selectedMode == mode) return;
    _selectedMode = mode;
    final modePresets = SoundscapePresets.getByMode(mode);
    if (modePresets.isNotEmpty) {
      // Auto-switch to first preset in newly selected mode
      selectSoundscape(modePresets.first, autoPlay: _isPlaying);
    }
    notifyListeners();
  }

  Future<void> selectSoundscape(Soundscape soundscape, {bool autoPlay = true}) async {
    _currentSoundscape = soundscape;
    _selectedMode = soundscape.mode;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();

    try {
      await audioService.loadSoundscape(soundscape, autoPlay: autoPlay);
      await storageService.setLastSoundscapeId(soundscape.id);
    } catch (e) {
      _errorMessage = 'Could not stream soundscape: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> togglePlayPause() async {
    _errorMessage = null;
    try {
      if (audioService.currentSoundscape == null) {
        await selectSoundscape(_currentSoundscape, autoPlay: true);
      } else {
        await audioService.togglePlayPause();
      }
    } catch (e) {
      _errorMessage = 'Audio error: $e';
      notifyListeners();
    }
  }

  Future<void> setVolume(double value) async {
    _volume = value;
    await audioService.setVolume(value);
    await storageService.setMasterVolume(value);
    notifyListeners();
  }

  Future<void> setIntensity(double value) async {
    _intensity = value;
    await audioService.setIntensity(value);
    await storageService.setIntensity(value);
    notifyListeners();
  }

  Future<void> toggleBinaural() async {
    _binauralEnabled = !_binauralEnabled;
    await storageService.setBinauralEnabled(_binauralEnabled);
    notifyListeners();
  }

  @override
  void dispose() {
    _playerStateSub?.cancel();
    _soundscapeSub?.cancel();
    super.dispose();
  }
}
