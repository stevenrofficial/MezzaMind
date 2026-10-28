import 'package:flutter/material.dart';
import 'soundscape_mode.dart';

class Soundscape {
  final String id;
  final String title;
  final String subtitle;
  final SoundscapeMode mode;
  final String audioUrl;
  final String binauralHz;
  final String tag;
  final Color primaryColor;
  final Color accentColor;
  final IconData icon;
  final double defaultIntensity;
  final int? bpm;
  final String? genre;
  final bool hasRhythmBeat;

  const Soundscape({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.mode,
    required this.audioUrl,
    required this.binauralHz,
    required this.tag,
    required this.primaryColor,
    required this.accentColor,
    required this.icon,
    this.defaultIntensity = 0.75,
    this.bpm,
    this.genre,
    this.hasRhythmBeat = false,
  });

  Soundscape copyWith({
    String? id,
    String? title,
    String? subtitle,
    SoundscapeMode? mode,
    String? audioUrl,
    String? binauralHz,
    String? tag,
    Color? primaryColor,
    Color? accentColor,
    IconData? icon,
    double? defaultIntensity,
    int? bpm,
    String? genre,
    bool? hasRhythmBeat,
  }) {
    return Soundscape(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      mode: mode ?? this.mode,
      audioUrl: audioUrl ?? this.audioUrl,
      binauralHz: binauralHz ?? this.binauralHz,
      tag: tag ?? this.tag,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      icon: icon ?? this.icon,
      defaultIntensity: defaultIntensity ?? this.defaultIntensity,
      bpm: bpm ?? this.bpm,
      genre: genre ?? this.genre,
      hasRhythmBeat: hasRhythmBeat ?? this.hasRhythmBeat,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Soundscape &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
