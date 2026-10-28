import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../player/models/soundscape_mode.dart';
import '../models/google_flow_track.dart';

class GoogleFlowService extends ChangeNotifier {
  static const String _storageKey = 'google_flow_imported_tracks';
  final SharedPreferences _prefs;

  final List<GoogleFlowTrack> _tracks = [];

  GoogleFlowService(this._prefs) {
    _loadTracks();
  }

  List<GoogleFlowTrack> get tracks => List.unmodifiable(_tracks);

  void _loadTracks() {
    final rawList = _prefs.getStringList(_storageKey) ?? [];
    _tracks.clear();

    for (final item in rawList) {
      try {
        final decoded = jsonDecode(item) as Map<String, dynamic>;
        _tracks.add(GoogleFlowTrack.fromJson(decoded));
      } catch (e) {
        debugPrint('MezzaMind: Error decoding Google Flow track -> $e');
      }
    }

    // If empty, add a default preloaded Google Flow AI demo track
    if (_tracks.isEmpty) {
      _tracks.add(
        GoogleFlowTrack(
          id: 'google_flow_demo_1',
          title: 'Google Flow AI • Fluid Cognition',
          audioPath: 'assets/audio/songs/google_flow_sample.wav',
          isRemote: false,
          mode: SoundscapeMode.deepFocus,
          targetBrainwave: '28 Hz Beta/Gamma',
          bpm: 120,
          dateAdded: DateTime.now(),
        ),
      );
      _persist();
    }

    notifyListeners();
  }

  Future<void> _persist() async {
    final rawList = _tracks.map((t) => jsonEncode(t.toJson())).toList();
    await _prefs.setStringList(_storageKey, rawList);
  }

  /// Pick an exported audio file (.mp3, .wav, .m4a, .ogg) from phone storage
  Future<GoogleFlowTrack?> pickAndImportFile({
    required SoundscapeMode mode,
    required String targetBrainwave,
    String? customTitle,
    int? bpm,
  }) async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a', 'ogg', 'aac', 'flac'],
      );

      if (files.isNotEmpty) {
        final file = files.first;
        final path = file.path;
        if (path == null) return null;

        final trackTitle = (customTitle != null && customTitle.trim().isNotEmpty)
            ? customTitle.trim()
            : (file.name.replaceAll(RegExp(r'\.[a-zA-Z0-9]+$'), ''));

        final newTrack = GoogleFlowTrack(
          id: 'flow_${DateTime.now().millisecondsSinceEpoch}',
          title: trackTitle,
          audioPath: path,
          isRemote: false,
          mode: mode,
          targetBrainwave: targetBrainwave,
          bpm: bpm,
          dateAdded: DateTime.now(),
        );

        _tracks.insert(0, newTrack);
        await _persist();
        notifyListeners();
        return newTrack;
      }
    } catch (e) {
      debugPrint('MezzaMind: FilePicker error -> $e');
      rethrow;
    }
    return null;
  }

  /// Import by direct audio stream URL from Google Flow / Google Cloud
  Future<GoogleFlowTrack> importFromUrl({
    required String url,
    required String title,
    required SoundscapeMode mode,
    required String targetBrainwave,
    int? bpm,
  }) async {
    final newTrack = GoogleFlowTrack(
      id: 'flow_url_${DateTime.now().millisecondsSinceEpoch}',
      title: title.trim().isEmpty ? 'Google Flow Cloud Stream' : title.trim(),
      audioPath: url.trim(),
      isRemote: true,
      mode: mode,
      targetBrainwave: targetBrainwave,
      bpm: bpm,
      dateAdded: DateTime.now(),
    );

    _tracks.insert(0, newTrack);
    await _persist();
    notifyListeners();
    return newTrack;
  }

  Future<void> removeTrack(String trackId) async {
    _tracks.removeWhere((t) => t.id == trackId);
    await _persist();
    notifyListeners();
  }
}
