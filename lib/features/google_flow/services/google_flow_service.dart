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

    // Ensure the user's liked song "Hypnotic 909 Pulse" is always present in library
    final has909 = _tracks.any((t) => t.id == 'flow_hypnotic_909');
    if (!has909) {
      _tracks.insert(
        0,
        GoogleFlowTrack(
          id: 'flow_hypnotic_909',
          title: 'Hypnotic 909 Pulse',
          audioPath: 'assets/audio/songs/hypnotic_909_pulse.m4a',
          isRemote: false,
          mode: SoundscapeMode.deepFocus,
          targetBrainwave: '14–40 Hz Beta/Gamma',
          bpm: 138,
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

  static final RegExp _flowMusicUrlPattern =
      RegExp(r'(?:flowmusic\.app/song/|clips/)([a-zA-Z0-9\-]+)');

  /// Import by direct audio stream URL or FlowMusic app link
  Future<GoogleFlowTrack> importFromUrl({
    required String url,
    required String title,
    required SoundscapeMode mode,
    required String targetBrainwave,
    int? bpm,
  }) async {
    String resolvedAudioPath = url.trim();
    String resolvedTitle = title.trim();
    int? resolvedBpm = bpm;

    final match = _flowMusicUrlPattern.firstMatch(url);
    if (match != null) {
      final clipId = match.group(1)!;
      // Direct stream URL hosted on Google Cloud Storage
      resolvedAudioPath =
          'https://storage.googleapis.com/producer-app-public/clips/$clipId.m4a';

      if (resolvedTitle.isEmpty) {
        if (clipId.contains('3a48deae-a4ba-4362-9993-fd848b970bc7')) {
          resolvedTitle = 'Hypnotic 909 Pulse';
          resolvedBpm = 138;
        } else {
          resolvedTitle = 'Flow Music Track ($clipId)';
        }
      }
    }

    final newTrack = GoogleFlowTrack(
      id: 'flow_url_${DateTime.now().millisecondsSinceEpoch}',
      title: resolvedTitle.isEmpty ? 'Google Flow AI Track' : resolvedTitle,
      audioPath: resolvedAudioPath,
      isRemote: true,
      mode: mode,
      targetBrainwave: targetBrainwave,
      bpm: resolvedBpm ?? 138,
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
