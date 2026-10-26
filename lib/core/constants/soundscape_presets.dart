import 'package:flutter/material.dart';
import '../../features/player/models/soundscape.dart';
import '../../features/player/models/soundscape_mode.dart';
import 'app_colors.dart';

class SoundscapePresets {
  SoundscapePresets._();

  static const List<Soundscape> all = [
    // --- CODING FLOW ---
    Soundscape(
      id: 'cyber_rain',
      title: 'Neon Rain & Terminal',
      subtitle: 'Steady downpour over nocturnal city glass with rhythmic cadence',
      mode: SoundscapeMode.coding,
      audioUrl: 'https://actions.google.com/sounds/v1/weather/ambient_rain.ogg',
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
      audioUrl: 'https://actions.google.com/sounds/v1/science_fiction/alien_hum_loop.ogg',
      binauralHz: '14 Hz Beta Wave',
      tag: 'DEEP LOGIC',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.terminal_rounded,
      defaultIntensity: 0.7,
    ),
    Soundscape(
      id: 'cozy_lab',
      title: '3 AM Cyber Cafe',
      subtitle: 'Subtle muffled coffee lounge murmur with warm acoustic resonance',
      mode: SoundscapeMode.coding,
      audioUrl: 'https://actions.google.com/sounds/v1/ambiences/coffee_shop.ogg',
      binauralHz: '18 Hz Beta Wave',
      tag: 'COLLAB FOCUS',
      primaryColor: AppColors.amberAccent,
      accentColor: AppColors.roseAccent,
      icon: Icons.coffee_rounded,
      defaultIntensity: 0.65,
    ),

    // --- DEEP FOCUS ---
    Soundscape(
      id: 'gamma_singularity',
      title: '40Hz Gamma Singularity',
      subtitle: 'Synchronized cognitive entrainment for maximum bandwidth',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'https://actions.google.com/sounds/v1/weather/wind_synthetic.ogg',
      binauralHz: '40 Hz Gamma',
      tag: 'COGNITIVE BOOST',
      primaryColor: AppColors.cyanAccent,
      accentColor: AppColors.emeraldAccent,
      icon: Icons.bolt_rounded,
      defaultIntensity: 0.85,
    ),
    Soundscape(
      id: 'storm_over_himalayas',
      title: 'Himalayan Ridge Storm',
      subtitle: 'Distant rolling thunder and deep mountain pressure',
      mode: SoundscapeMode.deepFocus,
      audioUrl: 'https://actions.google.com/sounds/v1/weather/thunderstorm.ogg',
      binauralHz: '38 Hz Gamma',
      tag: 'INTENSE FLOW',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.thunderstorm_rounded,
      defaultIntensity: 0.75,
    ),

    // --- ZEN RELAX ---
    Soundscape(
      id: 'kyoto_bamboo_stream',
      title: 'Kyoto Bamboo Spring',
      subtitle: 'Pristine flowing alpine stream clearing mental fatigue',
      mode: SoundscapeMode.relax,
      audioUrl: 'https://actions.google.com/sounds/v1/water/stream_water.ogg',
      binauralHz: '6 Hz Theta Wave',
      tag: 'MINDFULNESS',
      primaryColor: AppColors.emeraldAccent,
      accentColor: AppColors.tealAccent,
      icon: Icons.waves_rounded,
      defaultIntensity: 0.7,
    ),
    Soundscape(
      id: 'celestial_drift',
      title: 'Celestial Drift',
      subtitle: 'Smooth ambient harmonics to untangle post-sprint exhaustion',
      mode: SoundscapeMode.relax,
      audioUrl: 'https://actions.google.com/sounds/v1/science_fiction/alien_hum_loop.ogg',
      binauralHz: '7.83 Hz Schumann',
      tag: 'REST & RESTORE',
      primaryColor: AppColors.roseAccent,
      accentColor: AppColors.amberAccent,
      icon: Icons.blur_on_rounded,
      defaultIntensity: 0.6,
    ),

    // --- DEEP SLEEP ---
    Soundscape(
      id: 'heavy_roof_downpour',
      title: 'Nocturnal Roof Rain',
      subtitle: 'Warm rhythmic downpour inducing rapid Delta phase sleep',
      mode: SoundscapeMode.sleep,
      audioUrl: 'https://actions.google.com/sounds/v1/weather/rain_heavy.ogg',
      binauralHz: '2 Hz Delta Wave',
      tag: 'RESTFUL SLEEP',
      primaryColor: AppColors.violetAccent,
      accentColor: AppColors.emeraldAccent,
      icon: Icons.bedtime_rounded,
      defaultIntensity: 0.6,
    ),
    Soundscape(
      id: 'deep_ocean_abyss',
      title: 'Deep Ocean Trench',
      subtitle: 'Slow breathing sub-aquatic tidal rhythm for nervous system reset',
      mode: SoundscapeMode.sleep,
      audioUrl: 'https://actions.google.com/sounds/v1/water/stream_water.ogg',
      binauralHz: '1.5 Hz Delta Wave',
      tag: 'SLOW-WAVE REST',
      primaryColor: AppColors.tealAccent,
      accentColor: AppColors.cyanAccent,
      icon: Icons.nightlight_round,
      defaultIntensity: 0.55,
    ),
  ];

  static List<Soundscape> getByMode(SoundscapeMode mode) {
    return all.where((s) => s.mode == mode).toList();
  }

  static Soundscape get defaultSoundscape => all.first;
}
