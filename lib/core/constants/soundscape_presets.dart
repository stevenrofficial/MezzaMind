import 'package:flutter/material.dart';
import '../../features/player/models/soundscape.dart';
import '../../features/player/models/soundscape_mode.dart';
import 'app_colors.dart';

class SoundscapePresets {
  SoundscapePresets._();

  static const List<Soundscape> all = [
    // ==========================================
    // 🎧 FUNCTIONAL RHYTHMIC SONGS
    // ==========================================

    // SONG 1: 124 BPM Minimal Cyber Techno (Beta)
    Soundscape(
      id: 'song_cyberpunk_terminal',
      title: 'Cyberpunk Terminal',
      subtitle: '124 BPM driving minimal techno with hypnotic arpeggiated bass & rain',
      mode: SoundscapeMode.coding,
      audioUrl: 'assets/audio/songs/cyberpunk_terminal.wav',
      binauralHz: '16 Hz Beta Wave',
      tag: '124 BPM • TECHNO',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.graphic_eq_rounded,
      bpm: 124,
      genre: 'MINIMAL TECHNO',
      hasRhythmBeat: true,
      defaultIntensity: 0.85,
    ),

    // SONG 2: 128 BPM Modular Electronic Pulse (Gamma)
    Soundscape(
      id: 'song_gamma_hyperdrive',
      title: 'Gamma Hyperdrive',
      subtitle: '128 BPM fast-paced modular pulse with 40Hz cognitive entrainment',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'assets/audio/songs/gamma_hyperdrive.wav',
      binauralHz: '40 Hz Gamma Wave',
      tag: '128 BPM • MODULAR',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.bolt_rounded,
      bpm: 128,
      genre: 'MODULAR PULSE',
      hasRhythmBeat: true,
      defaultIntensity: 0.9,
    ),

    // SONG 3: 85 BPM Lo-Fi Hip Hop Beat (Alpha)
    Soundscape(
      id: 'song_lofi_circuit',
      title: 'Midnight Lo-Fi Circuit',
      subtitle: '85 BPM boom-bap drums with electric piano chords & vinyl tape warmth',
      mode: SoundscapeMode.coding,
      audioUrl: 'assets/audio/songs/midnight_lofi_circuit.wav',
      binauralHz: '12 Hz Alpha Wave',
      tag: '85 BPM • LO-FI',
      primaryColor: AppColors.amberAccent,
      accentColor: AppColors.roseAccent,
      icon: Icons.album_rounded,
      bpm: 85,
      genre: 'LO-FI CHILL',
      hasRhythmBeat: true,
      defaultIntensity: 0.75,
    ),

    // SONG 4: 78 BPM Organic Downtempo Dub (Theta)
    Soundscape(
      id: 'song_kyoto_downtempo',
      title: 'Kyoto Downtempo Dub',
      subtitle: '78 BPM organic downtempo groove with bamboo clicks & alpine water',
      mode: SoundscapeMode.relax,
      audioUrl: 'assets/audio/songs/kyoto_downtempo.wav',
      binauralHz: '6 Hz Theta Wave',
      tag: '78 BPM • DOWNTEMPO',
      primaryColor: AppColors.emeraldAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.spa_rounded,
      bpm: 78,
      genre: 'AMBIENT DOWNTEMPO',
      hasRhythmBeat: true,
      defaultIntensity: 0.75,
    ),

    // SONG 5: 50 BPM Sub-Bass Heartbeat & Pad (Delta)
    Soundscape(
      id: 'song_nocturnal_delta',
      title: 'Nocturnal Delta Drift',
      subtitle: '50 BPM resting heartbeat pulse with deep chord swells & night rain',
      mode: SoundscapeMode.sleep,
      audioUrl: 'assets/audio/songs/nocturnal_delta_drift.wav',
      binauralHz: '2 Hz Delta Wave',
      tag: '50 BPM • HEARTBEAT',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.emeraldAccent,
      icon: Icons.nightlight_round,
      bpm: 50,
      genre: 'DELTA PULSE',
      hasRhythmBeat: true,
      defaultIntensity: 0.65,
    ),

    // ==========================================
    // 🌊 PURE AMBIENT & SOUNDSCAPES
    // ==========================================
    Soundscape(
      id: 'cyber_rain',
      title: 'Neon Rain & Terminal',
      subtitle: 'Steady downpour over nocturnal city glass with rhythmic cadence',
      mode: SoundscapeMode.coding,
      audioUrl: 'assets/audio/cyber_rain.wav',
      binauralHz: '16 Hz Beta Wave',
      tag: 'FLOW STATE',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.water_drop_rounded,
      defaultIntensity: 0.8,
    ),
    Soundscape(
      id: 'midnight_monolith',
      title: 'Midnight Monolith',
      subtitle: 'Low-frequency resonant hum for architecture and syntax thinking',
      mode: SoundscapeMode.coding,
      audioUrl: 'assets/audio/midnight_monolith.wav',
      binauralHz: '14 Hz Beta Wave',
      tag: 'DEEP LOGIC',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.terminal_rounded,
      defaultIntensity: 0.7,
    ),
    Soundscape(
      id: 'gamma_singularity',
      title: '40Hz Gamma Singularity',
      subtitle: 'Synchronized cognitive entrainment for maximum bandwidth',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'assets/audio/gamma_singularity.wav',
      binauralHz: '40 Hz Gamma',
      tag: 'COGNITIVE BOOST',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.emeraldAccent,
      icon: Icons.bolt_rounded,
      defaultIntensity: 0.85,
    ),
    Soundscape(
      id: 'kyoto_bamboo_stream',
      title: 'Kyoto Bamboo Spring',
      subtitle: 'Pristine flowing alpine stream clearing mental fatigue',
      mode: SoundscapeMode.relax,
      audioUrl: 'assets/audio/kyoto_stream.wav',
      binauralHz: '6 Hz Theta Wave',
      tag: 'MINDFULNESS',
      primaryColor: AppColors.emeraldAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.waves_rounded,
      defaultIntensity: 0.7,
    ),
    Soundscape(
      id: 'deep_ocean_abyss',
      title: 'Deep Ocean Trench',
      subtitle: 'Slow breathing sub-aquatic tidal rhythm for nervous system reset',
      mode: SoundscapeMode.sleep,
      audioUrl: 'assets/audio/ocean_abyss.wav',
      binauralHz: '1.5 Hz Delta Wave',
      tag: 'SLOW-WAVE REST',
      primaryColor: AppColors.tealAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.nightlight_round,
      defaultIntensity: 0.55,
    ),
  ];

  static List<Soundscape> get rhythmicSongs =>
      all.where((s) => s.hasRhythmBeat).toList();

  static List<Soundscape> get pureAmbience =>
      all.where((s) => !s.hasRhythmBeat).toList();

  static List<Soundscape> getByMode(SoundscapeMode mode) {
    return all.where((s) => s.mode == mode).toList();
  }

  static Soundscape get defaultSoundscape => all.first;
}
