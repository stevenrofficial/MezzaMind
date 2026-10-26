import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../core/services/audio_engine_service.dart';
import '../../../core/services/storage_service.dart';
import '../models/timer_mode.dart';

class TimerViewModel extends ChangeNotifier {
  final StorageService storageService;
  final AudioEngineService audioService;

  static const List<FocusPreset> presets = [
    FocusPreset(label: '15m', minutes: 15, tag: 'Quick Sprint'),
    FocusPreset(label: '25m', minutes: 25, tag: 'Classic Pomodoro'),
    FocusPreset(label: '45m', minutes: 45, tag: 'Deep Dive'),
    FocusPreset(label: '60m', minutes: 60, tag: 'Architecture'),
    FocusPreset(label: '90m', minutes: 90, tag: 'Ultradian Flow'),
  ];

  TimerType _type = TimerType.countdown;
  TimerStatus _status = TimerStatus.idle;
  FocusPreset _selectedPreset = presets[1]; // default 25m

  int _totalSeconds = 25 * 60;
  int _remainingSeconds = 25 * 60;
  int _elapsedSeconds = 0;

  bool _fadeAudioOnComplete = true;
  Timer? _ticker;

  TimerViewModel({
    required this.storageService,
    required this.audioService,
  });

  TimerType get type => _type;
  TimerStatus get status => _status;
  FocusPreset get selectedPreset => _selectedPreset;
  int get remainingSeconds => _remainingSeconds;
  int get elapsedSeconds => _elapsedSeconds;
  int get totalSeconds => _totalSeconds;
  bool get fadeAudioOnComplete => _fadeAudioOnComplete;
  bool get isRunning => _status == TimerStatus.running;

  double get progress {
    if (_type == TimerType.countUp) {
      return 1.0;
    }
    if (_totalSeconds == 0) return 0.0;
    return (_totalSeconds - _remainingSeconds) / _totalSeconds;
  }

  String get formattedTime {
    final secs = _type == TimerType.countdown ? _remainingSeconds : _elapsedSeconds;
    final minutes = (secs ~/ 60).toString().padLeft(2, '0');
    final seconds = (secs % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void selectPreset(FocusPreset preset) {
    if (isRunning) return;
    _selectedPreset = preset;
    _type = TimerType.countdown;
    _totalSeconds = preset.duration.inSeconds;
    _remainingSeconds = _totalSeconds;
    _elapsedSeconds = 0;
    _status = TimerStatus.idle;
    notifyListeners();
  }

  void setTimerType(TimerType type) {
    if (isRunning) return;
    _type = type;
    reset();
  }

  void toggleFadeAudioOnComplete() {
    _fadeAudioOnComplete = !_fadeAudioOnComplete;
    notifyListeners();
  }

  void start() {
    if (_status == TimerStatus.running) return;

    _status = TimerStatus.running;
    notifyListeners();

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_type == TimerType.countdown) {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _elapsedSeconds++;
          notifyListeners();
        } else {
          _onCountdownCompleted();
        }
      } else {
        _elapsedSeconds++;
        notifyListeners();
      }
    });
  }

  void pause() {
    if (_status != TimerStatus.running) return;
    _ticker?.cancel();
    _status = TimerStatus.paused;
    notifyListeners();
  }

  void resume() {
    if (_status == TimerStatus.paused) {
      start();
    }
  }

  void reset() {
    _ticker?.cancel();
    _status = TimerStatus.idle;
    if (_type == TimerType.countdown) {
      _remainingSeconds = _totalSeconds;
    } else {
      _remainingSeconds = 0;
    }
    _elapsedSeconds = 0;
    notifyListeners();
  }

  Future<void> _onCountdownCompleted() async {
    _ticker?.cancel();
    _status = TimerStatus.completed;
    notifyListeners();

    final completedMinutes = _totalSeconds ~/ 60;
    await storageService.addFocusMinutes(completedMinutes);
    await storageService.incrementCompletedSessions();

    if (_fadeAudioOnComplete) {
      await audioService.fadeOut();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
