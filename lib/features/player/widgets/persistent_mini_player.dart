import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/soundscape.dart';

class PersistentMiniPlayer extends StatelessWidget {
  final Soundscape? soundscape;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onTogglePlay;
  final VoidCallback onTap;

  const PersistentMiniPlayer({
    super.key,
    required this.soundscape,
    required this.isPlaying,
    required this.isLoading,
    required this.onTogglePlay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (soundscape == null) return const SizedBox.shrink();

    final item = soundscape!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: item.primaryColor.withOpacity(isPlaying ? 0.4 : 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Soundscape Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.primaryColor.withOpacity(0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item.icon,
                color: item.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Soundscape details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPlaying ? AppColors.activeGreen : AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.mode.title} • ${item.binauralHz}',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: item.primaryColor.withOpacity(0.85),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Play/Pause Action
            IconButton(
              onPressed: onTogglePlay,
              icon: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(item.primaryColor),
                      ),
                    )
                  : Icon(
                      isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                      size: 34,
                      color: item.primaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

