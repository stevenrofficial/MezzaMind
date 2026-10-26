import 'package:flutter/foundation.dart';
import '../../../core/services/storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final StorageService storageService;

  bool _oledPureBlack = false;
  int _totalFocusMinutes = 0;
  int _completedSessions = 0;

  SettingsViewModel({required this.storageService}) {
    _load();
  }

  bool get oledPureBlack => _oledPureBlack;
  int get totalFocusMinutes => _totalFocusMinutes;
  int get completedSessions => _completedSessions;

  void _load() {
    _oledPureBlack = storageService.getOledPureBlack();
    _totalFocusMinutes = storageService.getTotalFocusMinutes();
    _completedSessions = storageService.getCompletedSessions();
    notifyListeners();
  }

  void refreshStats() {
    _totalFocusMinutes = storageService.getTotalFocusMinutes();
    _completedSessions = storageService.getCompletedSessions();
    notifyListeners();
  }

  Future<void> toggleOledPureBlack() async {
    _oledPureBlack = !_oledPureBlack;
    await storageService.setOledPureBlack(_oledPureBlack);
    notifyListeners();
  }

  Future<void> resetStats() async {
    await storageService.clearAll();
    _load();
  }
}
