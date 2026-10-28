import 'package:flutter/material.dart';

enum SoundscapeMode {
  coding(
    id: 'coding',
    title: 'Coding Flow',
    subtitle: 'Beta waves (14-20Hz) for deep engineering & logic sprints',
    icon: Icons.code_rounded,
    badge: '16Hz BETA',
  ),
  deepFocus(
    id: 'deep_focus',
    title: 'Deep Focus',
    subtitle: 'Gamma waves (40Hz) for hyper-focus & cognitive bandwidth',
    icon: Icons.psychology_alt_rounded,
    badge: '40Hz GAMMA',
  ),
  relax(
    id: 'relax',
    title: 'Zen Relax',
    subtitle: 'Theta waves (4-7Hz) for mental decluttering & meditation',
    icon: Icons.spa_rounded,
    badge: '6Hz THETA',
  ),
  sleep(
    id: 'sleep',
    title: 'Deep Sleep',
    subtitle: 'Delta waves (0.5-4Hz) for restful slow-wave brain recovery',
    icon: Icons.nights_stay_rounded,
    badge: '2Hz DELTA',
  );

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String badge;

  const SoundscapeMode({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.badge,
  });
}

