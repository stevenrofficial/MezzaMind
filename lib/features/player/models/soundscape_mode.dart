import 'package:flutter/material.dart';

enum SoundscapeMode {
  deepFocus(
    id: 'deep_focus',
    title: 'Deep Focus & Coding',
    shortTitle: 'Focus / Code',
    targetBrainwave: 'Beta / Low Gamma (14 Hz – 40 Hz)',
    badge: '14–40Hz BETA/GAMMA',
    idealSessionLength: '50 to 90 mins',
    defaultMinutes: 60,
    musicProfile:
        'Minimalist neo-classical piano, sparse modular synth pads, & organic rhythmic cadence (50–70 BPM). No lyrics.',
    whyItWorks:
        'Keeps alertness high while maintaining steady pacing. Repetitive patterns mirror writing clean code and prevent lyrical anticipation.',
    icon: Icons.code_rounded,
  ),
  creativity(
    id: 'creativity',
    title: 'Creativity & Ideation',
    shortTitle: 'Creativity',
    targetBrainwave: 'Alpha / Theta Bridge (8 Hz – 12 Hz)',
    badge: '8–12Hz ALPHA/THETA',
    idealSessionLength: '30 to 45 mins',
    defaultMinutes: 45,
    musicProfile:
        'Warm ambient soundscapes, lush textural design, & filtered acoustic instruments with wide stereo panning.',
    whyItWorks:
        'Frees up associative thinking by gently lowering analytical filters, encouraging lateral problem-solving.',
    icon: Icons.lightbulb_outline_rounded,
  ),
  calm(
    id: 'calm',
    title: 'Calm & Stress Relief',
    shortTitle: 'Calm / Reset',
    targetBrainwave: 'Alpha Waves (8 Hz – 10 Hz)',
    badge: '8–10Hz ALPHA',
    idealSessionLength: '15 to 30 mins',
    defaultMinutes: 20,
    musicProfile:
        'Slow-tempo warm chord progressions, soft cello drones, harmonic chimes, & gentle vinyl warmth.',
    whyItWorks:
        'Calms the autonomic nervous system and lowers cortisol following high-stress debug sessions or intense sprints.',
    icon: Icons.spa_rounded,
  ),
  sleep(
    id: 'sleep',
    title: 'Sleep & Deep Rest',
    shortTitle: 'Sleep / Rest',
    targetBrainwave: 'Delta Waves (0.5 Hz – 4 Hz)',
    badge: '0.5–4Hz DELTA',
    idealSessionLength: '45 mins to 8 hours',
    defaultMinutes: 60,
    musicProfile:
        'Deep sub-bass brown noise, ultra-slow drone pads, & oceanic sub-frequencies with zero sudden dynamic spikes.',
    whyItWorks:
        'Encourages transition into restorative slow-wave sleep by matching the brain\'s lowest electrical firing frequency.',
    icon: Icons.nights_stay_rounded,
  );

  final String id;
  final String title;
  final String shortTitle;
  final String targetBrainwave;
  final String badge;
  final String idealSessionLength;
  final int defaultMinutes;
  final String musicProfile;
  final String whyItWorks;
  final IconData icon;

  const SoundscapeMode({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.targetBrainwave,
    required this.badge,
    required this.idealSessionLength,
    required this.defaultMinutes,
    required this.musicProfile,
    required this.whyItWorks,
    required this.icon,
  });
}
