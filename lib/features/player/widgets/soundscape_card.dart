import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/soundscape.dart';

class SoundscapeCard extends StatelessWidget {
  final Soundscape soundscape;
  final bool isSelected;
  final bool isPlaying;
  final VoidCallback onTap;

  const SoundscapeCard({
    super.key,
    required this.soundscape,
    required this.isSelected,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? soundscape.primaryColor.withOpacity(0.08)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? soundscape.primaryColor.withOpacity(0.5)
                : AppColors.borderSubtle,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: soundscape.primaryColor.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon / Avatar container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: soundscape.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: soundscape.primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                soundscape.icon,
                color: soundscape.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),

            // Soundscape Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          soundscape.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: soundscape.primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          soundscape.tag,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: soundscape.primaryColor,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    soundscape.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    soundscape.binauralHz,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: soundscape.primaryColor.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Play / Indicator Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? soundscape.primaryColor.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: Center(
                child: isSelected && isPlaying
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: _ActiveWaveIndicator(color: soundscape.primaryColor),
                      )
                    : Icon(
                        isSelected ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        size: 20,
                        color: isSelected
                            ? soundscape.primaryColor
                            : AppColors.textTertiary,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveWaveIndicator extends StatelessWidget {
  final Color color;
  const _ActiveWaveIndicator({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _WaveBar(color: color, height: 12),
        _WaveBar(color: color, height: 16),
        _WaveBar(color: color, height: 10),
      ],
    );
  }
}

class _WaveBar extends StatelessWidget {
  final Color color;
  final double height;
  const _WaveBar({required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.5,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
