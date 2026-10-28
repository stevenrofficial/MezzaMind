import 'package:flutter/material.dart';
import '../../features/player/models/soundscape.dart';
import '../../features/player/models/soundscape_mode.dart';
import 'app_colors.dart';

class SoundscapePresets {
  SoundscapePresets._();

  static const List<Soundscape> all = [
    // =========================================================================
    // 1. DEEP FOCUS / CODING (Beta / Low Gamma: 14 Hz – 40 Hz • 50–90 mins)
    // =========================================================================
    Soundscape(
      id: 'hightech_138_techno',
      title: 'High-Tech 138 • Neural Drive',
      subtitle: 'Driving 138 BPM hypnotic minimal techno groove, 909 drums, micro-percussion, rolling analog bass & 14-40Hz pulse',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'assets/audio/songs/hightech_138_techno.wav',
      binauralHz: '14–40 Hz Beta/Gamma',
      tag: '138 BPM • TECHNO',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.violetAccent,
      icon: Icons.bolt_rounded,
      bpm: 138,
      genre: 'MINIMAL HIGH-TECH',
      hasRhythmBeat: true,
      defaultIntensity: 0.9,
    ),
    Soundscape(
      id: 'neoclassical_focus',
      title: 'Neo-Classical Code Arpeggio',
      subtitle: 'Minimalist felt piano arpeggios, sparse modular pads & clean 60 BPM transient tick',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'assets/audio/songs/neoclassical_focus.wav',
      binauralHz: '16 Hz Beta Wave',
      tag: '60 BPM • NEO-CLASSICAL',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.piano_rounded,
      bpm: 60,
      genre: 'NEO-CLASSICAL PIANO',
      hasRhythmBeat: true,
      defaultIntensity: 0.85,
    ),
    Soundscape(
      id: 'modular_synth_flow',
      title: 'Modular Synth Flow',
      subtitle: 'Sparse modular synth pads & steady organic cadence for sustained logic sprints',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'assets/audio/songs/modular_synth_flow.wav',
      binauralHz: '40 Hz Low Gamma',
      tag: '68 BPM • MODULAR',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.terminal_rounded,
      bpm: 68,
      genre: 'MODULAR AMBIENT',
      hasRhythmBeat: true,
      defaultIntensity: 0.8,
    ),
    Soundscape(
      id: 'cyber_rain',
      title: 'Midnight Rain on Glass',
      subtitle: 'Steady nocturnal downpour with low-frequency resonant hum',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'assets/audio/cyber_rain.wav',
      binauralHz: '16 Hz Beta Wave',
      tag: 'SOUNDSCAPE',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.emeraldAccent,
      icon: Icons.water_drop_rounded,
      defaultIntensity: 0.75,
    ),

    // =========================================================================
    // 2. CREATIVITY / IDEATION (Alpha / Theta Bridge: 8 Hz – 12 Hz • 30–45 mins)
    // =========================================================================
    Soundscape(
      id: 'ideation_bloom',
      title: 'Ideation Bloom',
      subtitle: 'Warm ambient textures & filtered acoustic instrument harmonics with wide stereo panning',
      mode: SoundscapeMode.creativity,
      audioUrl: 'assets/audio/songs/ideation_bloom.wav',
      binauralHz: '10 Hz Alpha/Theta Bridge',
      tag: '72 BPM • ACOUSTIC AMBIENT',
      primaryColor: AppColors.amberAccent,
      accentColor: AppColors.roseAccent,
      icon: Icons.lightbulb_outline_rounded,
      bpm: 72,
      genre: 'FILTERED ACOUSTIC',
      hasRhythmBeat: true,
      defaultIntensity: 0.75,
    ),
    Soundscape(
      id: 'kyoto_bamboo_spring',
      title: 'Kyoto Bamboo Spring',
      subtitle: 'Alpine stream resonances lowering analytical filters for lateral problem-solving',
      mode: SoundscapeMode.creativity,
      audioUrl: 'assets/audio/kyoto_stream.wav',
      binauralHz: '8 Hz Alpha/Theta',
      tag: 'SOUNDSCAPE',
      primaryColor: AppColors.emeraldAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.waves_rounded,
      defaultIntensity: 0.7,
    ),

    // =========================================================================
    // 3. CALM / STRESS RELIEF (Alpha Waves: 8 Hz – 10 Hz • 15–30 mins)
    // =========================================================================
    Soundscape(
      id: 'calm_cello_vinyl',
      title: 'Harmonic Cello & Vinyl',
      subtitle: 'Slow-tempo warm chord progressions, soft cello drones, harmonic chimes & vinyl warmth',
      mode: SoundscapeMode.calm,
      audioUrl: 'assets/audio/songs/calm_cello_vinyl.wav',
      binauralHz: '9 Hz Alpha Wave',
      tag: '54 BPM • CELLO DRONE',
      primaryColor: AppColors.roseAccent,
      accentColor: AppColors.violetAccent,
      icon: Icons.music_note_rounded,
      bpm: 54,
      genre: 'CELLO & CHIMES',
      hasRhythmBeat: true,
      defaultIntensity: 0.7,
    ),
    Soundscape(
      id: 'celestial_drift',
      title: 'Celestial Drift & Wind',
      subtitle: 'Soft evening wind and harmonic drones calming autonomic nervous system tone',
      mode: SoundscapeMode.calm,
      audioUrl: 'assets/audio/celestial_drift.wav',
      binauralHz: '8.5 Hz Alpha Wave',
      tag: 'SOUNDSCAPE',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.roseAccent,
      icon: Icons.air_rounded,
      defaultIntensity: 0.65,
    ),

    // =========================================================================
    // 4. SLEEP / DEEP REST (Delta Waves: 0.5 Hz – 4 Hz • 45 mins to 8 hours)
    // =========================================================================
    Soundscape(
      id: 'oceanic_delta_sub',
      title: 'Oceanic Delta Sub-Bass',
      subtitle: 'Deep sub-bass brown noise, ultra-slow drone pads & zero sudden dynamic spikes',
      mode: SoundscapeMode.sleep,
      audioUrl: 'assets/audio/songs/oceanic_delta_sub.wav',
      binauralHz: '1.5 Hz Delta Wave',
      tag: '42 BPM • DELTA SUB',
      primaryColor: AppColors.tealAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.bedtime_rounded,
      bpm: 42,
      genre: 'SUB-BASS BROWN NOISE',
      hasRhythmBeat: true,
      defaultIntensity: 0.6,
    ),
    Soundscape(
      id: 'deep_sleep_rain',
      title: 'Nocturnal Heavy Downpour',
      subtitle: 'Deep low-pass roof rain encouraging transition into slow-wave restorative sleep',
      mode: SoundscapeMode.sleep,
      audioUrl: 'assets/audio/deep_sleep_rain.wav',
      binauralHz: '2 Hz Delta Wave',
      tag: 'SOUNDSCAPE',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.emeraldAccent,
      icon: Icons.nightlight_round,
      defaultIntensity: 0.55,
    ),
  ];

  static List<Soundscape> getByMode(SoundscapeMode mode) {
    return all.where((s) => s.mode == mode).toList();
  }

  static Soundscape get defaultSoundscape => all.first;
}
