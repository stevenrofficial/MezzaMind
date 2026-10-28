import 'package:flutter/material.dart';
import '../../player/models/soundscape.dart';
import '../../player/models/soundscape_mode.dart';

class GoogleFlowTrack {
  final String id;
  final String title;
  final String audioPath;
  final bool isRemote;
  final SoundscapeMode mode;
  final String targetBrainwave;
  final int? bpm;
  final DateTime dateAdded;

  const GoogleFlowTrack({
    required this.id,
    required this.title,
    required this.audioPath,
    required this.isRemote,
    required this.mode,
    required this.targetBrainwave,
    this.bpm,
    required this.dateAdded,
  });

  /// Converts this Google Flow track into a unified Soundscape model
  Soundscape toSoundscape() {
    return Soundscape(
      id: id,
      title: title,
      subtitle: 'Google Flow AI generation • Layered with $targetBrainwave',
      mode: mode,
      audioUrl: audioPath,
      binauralHz: targetBrainwave,
      tag: bpm != null ? '$bpm BPM • GOOGLE FLOW' : 'GOOGLE FLOW AI',
      primaryColor: const Color(0xFF4285F4), // Google Blue
      accentColor: const Color(0xFF34A853), // Google Green
      icon: Icons.auto_awesome_rounded,
      bpm: bpm,
      genre: 'GOOGLE FLOW GENERATIVE',
      hasRhythmBeat: true,
      defaultIntensity: 0.85,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'audioPath': audioPath,
        'isRemote': isRemote,
        'mode': mode.id,
        'targetBrainwave': targetBrainwave,
        'bpm': bpm,
        'dateAdded': dateAdded.toIso8601String(),
      };

  factory GoogleFlowTrack.fromJson(Map<String, dynamic> json) {
    final modeId = json['mode'] as String?;
    final mode = SoundscapeMode.values.firstWhere(
      (m) => m.id == modeId,
      orElse: () => SoundscapeMode.deepFocus,
    );

    return GoogleFlowTrack(
      id: json['id'] as String,
      title: json['title'] as String,
      audioPath: json['audioPath'] as String,
      isRemote: json['isRemote'] as bool? ?? false,
      mode: mode,
      targetBrainwave: json['targetBrainwave'] as String? ?? mode.badge,
      bpm: json['bpm'] as int?,
      dateAdded: DateTime.tryParse(json['dateAdded'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

