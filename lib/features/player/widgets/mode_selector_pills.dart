import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/soundscape_mode.dart';

class ModeSelectorPills extends StatelessWidget {
  final SoundscapeMode selectedMode;
  final ValueChanged<SoundscapeMode> onModeSelected;

  const ModeSelectorPills({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: SoundscapeMode.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final mode = SoundscapeMode.values[index];
          final isSelected = mode == selectedMode;

          return InkWell(
            onTap: () => onModeSelected(mode),
            borderRadius: BorderRadius.circular(22),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.cyanAccent.withOpacity(0.16)
                    : AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? AppColors.cyanAccent.withOpacity(0.6)
                      : AppColors.borderSubtle,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    mode.icon,
                    size: 16,
                    color: isSelected ? AppColors.cyanAccent : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    mode.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.cyanAccent.withOpacity(0.2)
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      mode.badge.split(' ').first,
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.cyanAccent
                            : AppColors.textTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
