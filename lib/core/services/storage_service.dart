import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyLastSoundscapeId = 'last_soundscape_id';
  static const String _keyMasterVolume = 'master_volume';
  static const String _keyIntensity = 'soundscape_intensity';
  static const String _keyTotalFocusMinutes = 'total_focus_minutes';
  static const String _keyCompletedSessions = 'completed_sessions';
  static const String _keyBinauralEnabled = 'binaural_enabled';
  static const String _keyOledPureBlack = 'oled_pure_black';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  String? getLastSoundscapeId() => _prefs.getString(_keyLastSoundscapeId);
  Future<void> setLastSoundscapeId(String id) =>
      _prefs.setString(_keyLastSoundscapeId, id);

  double getMasterVolume() => _prefs.getDouble(_keyMasterVolume) ?? 0.8;
  Future<void> setMasterVolume(double volume) =>
      _prefs.setDouble(_keyMasterVolume, volume);

  double getIntensity() => _prefs.getDouble(_keyIntensity) ?? 0.75;
  Future<void> setIntensity(double intensity) =>
      _prefs.setDouble(_keyIntensity, intensity);

  bool getBinauralEnabled() => _prefs.getBool(_keyBinauralEnabled) ?? true;
  Future<void> setBinauralEnabled(bool enabled) =>
      _prefs.setBool(_keyBinauralEnabled, enabled);

  bool getOledPureBlack() => _prefs.getBool(_keyOledPureBlack) ?? false;
  Future<void> setOledPureBlack(bool enabled) =>
      _prefs.setBool(_keyOledPureBlack, enabled);

  int getTotalFocusMinutes() => _prefs.getInt(_keyTotalFocusMinutes) ?? 0;
  Future<void> addFocusMinutes(int minutes) async {
    final current = getTotalFocusMinutes();
    await _prefs.setInt(_keyTotalFocusMinutes, current + minutes);
  }

  int getCompletedSessions() => _prefs.getInt(_keyCompletedSessions) ?? 0;
  Future<void> incrementCompletedSessions() async {
    final current = getCompletedSessions();
    await _prefs.setInt(_keyCompletedSessions, current + 1);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
