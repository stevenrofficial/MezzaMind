import 'dart:math' as math;
import 'package:flutter/material.dart';

class VisualizerOrb extends StatefulWidget {
  final bool isPlaying;
  final bool isLoading;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback onTap;

  const VisualizerOrb({
    super.key,
    required this.isPlaying,
    required this.isLoading,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
  });

  @override
  State<VisualizerOrb> createState() => _VisualizerOrbState();
}

class _VisualizerOrbState extends State<VisualizerOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(VisualizerOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.animateTo(0.0, duration: const Duration(milliseconds: 600));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Concentric Pulse Waves
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(250, 250),
                painter: _PulseWavePainter(
                  progress: _controller.value,
                  isPlaying: widget.isPlaying,
                  colorA: widget.primaryColor,
                  colorB: widget.secondaryColor,
                ),
              );
            },
          ),

          // Central Floating Glass Core & Play/Pause Button
          GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    widget.primaryColor.withOpacity(widget.isPlaying ? 0.35 : 0.15),
                    const Color(0xFF131722),
                  ],
                  stops: const [0.3, 1.0],
                ),
                border: Border.all(
                  color: widget.isPlaying
                      ? widget.primaryColor.withOpacity(0.8)
                      : Colors.white.withOpacity(0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withOpacity(widget.isPlaying ? 0.45 : 0.1),
                    blurRadius: widget.isPlaying ? 28 : 12,
                    spreadRadius: widget.isPlaying ? 4 : 0,
                  ),
                ],
              ),
              child: Center(
                child: widget.isLoading
                    ? SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(widget.primaryColor),
                        ),
                      )
                    : Icon(
                        widget.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 46,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseWavePainter extends CustomPainter {
  final double progress;
  final bool isPlaying;
  final Color colorA;
  final Color colorB;

  _PulseWavePainter({
    required this.progress,
    required this.isPlaying,
    required this.colorA,
    required this.colorB,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const ringCount = 3;
    final maxRadius = size.width / 2;

    if (!isPlaying) {
      // Idle resting subtle halo
      final idlePaint = Paint()
        ..color = colorA.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(center, 62, idlePaint);
      canvas.drawCircle(center, 78, idlePaint);
      return;
    }

    for (int i = 0; i < ringCount; i++) {
      final ringProgress = (progress + (i / ringCount)) % 1.0;
      final radius = 52.0 + ringProgress * (maxRadius - 52.0);
      final opacity = math.sin(ringProgress * math.pi) * 0.45;

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            colorA.withOpacity(opacity),
            colorB.withOpacity(opacity * 0.3),
            Colors.transparent,
          ],
          stops: const [0.7, 0.95, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8 + (1.0 - ringProgress) * 2.0;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PulseWavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isPlaying != isPlaying ||
        oldDelegate.colorA != colorA;
  }
}
