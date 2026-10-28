import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/timer_mode.dart';

class TimerCountdownClock extends StatelessWidget {
  final String formattedTime;
  final double progress;
  final TimerStatus status;
  final TimerType type;
  final Color accentColor;

  const TimerCountdownClock({
    super.key,
    required this.formattedTime,
    required this.progress,
    required this.status,
    required this.type,
    this.accentColor = AppColors.cyanAccent,
  });

  @override
  Widget build(BuildContext context) {
    final isRunning = status == TimerStatus.running;

    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Progress Track & Glow
          CustomPaint(
            size: const Size(240, 240),
            painter: _TimerRingPainter(
              progress: progress,
              isRunning: isRunning,
              accentColor: accentColor,
            ),
          ),

          // Central Time Typography
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                type == TimerType.countdown ? 'FOCUS SESSION' : 'OPEN SPRINT',
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 48,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: status == TimerStatus.running
                      ? accentColor.withOpacity(0.15)
                      : AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status == TimerStatus.running
                      ? 'IN PROGRESS'
                      : status == TimerStatus.completed
                          ? 'COMPLETED'
                          : status == TimerStatus.paused
                              ? 'PAUSED'
                              : 'READY',
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: status == TimerStatus.running
                        ? accentColor
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final bool isRunning;
  final Color accentColor;

  _TimerRingPainter({
    required this.progress,
    required this.isRunning,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 14;

    // Background track
    final trackPaint = Paint()
      ..color = AppColors.borderSubtle
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawCircle(center, radius, trackPaint);

    // Active progress arc
    final progressPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isRunning != isRunning ||
        oldDelegate.accentColor != accentColor;
  }
}

