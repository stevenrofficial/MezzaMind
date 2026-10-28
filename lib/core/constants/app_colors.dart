import 'package:flutter/material.dart';

/// App-wide color palette tailored for dark mode, late-night coding, and deep focus.
abstract final class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0A0C10);
  static const Color surface = Color(0xFF12151E);
  static const Color surfaceElevated = Color(0xFF191F2B);
  static const Color surfaceSubtle = Color(0xFF1E2638);

  // Borders & Dividers
  static const Color border = Color(0xFF263043);
  static const Color borderSubtle = Color(0xFF1E2535);

  // Accent Colors
  static const Color cyanAccent = Color(0xFF00E5FF);
  static const Color tealAccent = Color(0xFF14F1D9);
  static const Color emeraldAccent = Color(0xFF10B981);
  static const Color violetAccent = Color(0xFF8B5CF6);
  static const Color amberAccent = Color(0xFFF59E0B);
  static const Color roseAccent = Color(0xFFF43F5E);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF475569);

  // Functional Status
  static const Color activeGreen = Color(0xFF22C55E);
  static const Color warningOrange = Color(0xFFFB923C);
  static const Color errorRed = Color(0xFFEF4444);

  // Visualizer Gradients
  static const List<Color> cyanGradient = [
    Color(0xFF00E5FF),
    Color(0xFF0284C7),
  ];

  static const List<Color> purpleGradient = [
    Color(0xFFA855F7),
    Color(0xFF6366F1),
  ];

  static const List<Color> amberGradient = [
    Color(0xFFFBBF24),
    Color(0xFFEA580C),
  ];

  static const List<Color> emeraldGradient = [
    Color(0xFF34D399),
    Color(0xFF059669),
  ];
}

