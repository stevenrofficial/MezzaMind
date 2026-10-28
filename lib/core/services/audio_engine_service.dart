import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../features/player/models/soundscape.dart';

/// Audio Engine Service: Singleton managing ambient playback, looping,
/// background notification sync, and volume/intensity scaling.
class AudioEngineService {
  static final AudioEngineService _instance = AudioEngineService._internal();
  factory AudioEngineService() => _instance;
  AudioEngineService._internal();

  late final AudioPlayer _player;
  Soundscape? _currentSoundscape;
  double _volume = 0.8;
  double _intensity = 0.75;
  bool _isInitialized = false;

  final _currentSoundscapeController = StreamController<Soundscape?>.broadcast();
  final _volumeController = StreamController<double>.broadcast();
  final _intensityController = StreamController<double>.broadcast();

  // Public getters
  Soundscape? get currentSoundscape => _currentSoundscape;
  bool get isPlaying => _player.playing;
  double get volume => _volume;
  double get intensity => _intensity;
  bool get isInitialized => _isInitialized;

  // Streams
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<bool> get playingStream => _player.playingStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Soundscape?> get currentSoundscapeStream =>
      _currentSoundscapeController.stream;
  Stream<double> get volumeStream => _volumeController.stream;
  Stream<double> get intensityStream => _intensityController.stream;

  Future<void> init({double initialVolume = 0.8, double initialIntensity = 0.75}) async {
    if (_isInitialized) return;
    _volume = initialVolume;
    _intensity = initialIntensity;

    _player = AudioPlayer();

    // Ambient soundscapes should loop indefinitely
    await _player.setLoopMode(LoopMode.one);
    await _applyCalculatedVolume();

    _isInitialized = true;
  }

  /// Loads and optionally starts playing a soundscape
  Future<void> loadSoundscape(Soundscape soundscape, {bool autoPlay = true}) async {
    _currentSoundscape = soundscape;
    _currentSoundscapeController.add(soundscape);

    try {
      final mediaItem = MediaItem(
        id: soundscape.id,
        album: 'MezzaMind Ambient',
        title: soundscape.title,
        artist: '${soundscape.mode.title} • ${soundscape.binauralHz}',
        displayTitle: soundscape.title,
        displaySubtitle: soundscape.subtitle,
        displayDescription: soundscape.tag,
      );

      final AudioSource audioSource;
      if (soundscape.audioUrl.startsWith('http://') ||
          soundscape.audioUrl.startsWith('https://')) {
        audioSource = AudioSource.uri(
          Uri.parse(soundscape.audioUrl),
          tag: mediaItem,
        );
      } else if (soundscape.audioUrl.startsWith('assets/')) {
        // Load bundled offline asset
        audioSource = AudioSource.asset(
          soundscape.audioUrl,
          tag: mediaItem,
        );
      } else {
        // Load picked local storage file
        audioSource = AudioSource.file(
          soundscape.audioUrl,
          tag: mediaItem,
        );
      }

      await _player.setAudioSource(audioSource, preload: true);
      await _player.setLoopMode(LoopMode.one);
      await _applyCalculatedVolume();

      if (autoPlay) {
        await _player.play();
      }
    } catch (e) {
      debugPrint('MezzaMind Audio Engine: Error loading soundscape -> $e');
      rethrow;
    }
  }

  Future<void> play() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint('MezzaMind Audio Engine: Error playing -> $e');
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('MezzaMind Audio Engine: Error pausing -> $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await pause();
    } else {
      await play();
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Sets master output volume (0.0 - 1.0)
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    _volumeController.add(_volume);
    await _applyCalculatedVolume();
  }

  /// Sets ambient texture intensity (0.0 - 1.0), scaling audio dynamics
  Future<void> setIntensity(double intensity) async {
    _intensity = intensity.clamp(0.0, 1.0);
    _intensityController.add(_intensity);
    await _applyCalculatedVolume();
  }

  /// Smoothly fades out audio over a given duration (for sleep/pomodoro finish)
  Future<void> fadeOut({Duration duration = const Duration(seconds: 3)}) async {
    const steps = 15;
    final stepDuration = Duration(milliseconds: duration.inMilliseconds ~/ steps);
    final startVolume = _volume;

    for (int i = steps; i >= 0; i--) {
      final ratio = i / steps;
      await _player.setVolume(startVolume * ratio * _intensity);
      await Future.delayed(stepDuration);
    }

    await pause();
    // restore base volume calculation
    await _applyCalculatedVolume();
  }

  Future<void> _applyCalculatedVolume() async {
    // Effective volume combines master level with intensity scaling
    final effectiveVolume = (_volume * _intensity).clamp(0.0, 1.0);
    await _player.setVolume(effectiveVolume);
  }

  Future<void> dispose() async {
    await _player.dispose();
    await _currentSoundscapeController.close();
    await _volumeController.close();
    await _intensityController.close();
  }
}

