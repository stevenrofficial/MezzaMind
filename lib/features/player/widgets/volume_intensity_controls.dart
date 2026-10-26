import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class VolumeIntensityControls extends StatelessWidget {
  final double volume;
  final double intensity;
  final bool binauralEnabled;
  final ValueChanged<double> onVolumeChanged;
  final ValueChanged<double> onIntensityChanged;
  final VoidCallback onToggleBinaural;
  final Color accentColor;

  const VolumeIntensityControls({
    super.key,
    required this.volume,
    required this.intensity,
    required this.binauralEnabled,
    required this.onVolumeChanged,
    required this.onIntensityChanged,
    required this.onToggleBinaural,
    this.accentColor = AppColors.cyanAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          // Master Volume Control
          Row(
            children: [
              Icon(
                volume > 0.5
                    ? Icons.volume_up_rounded
                    : volume > 0.05
                        ? Icons.volume_down_rounded
                        : Icons.volume_mute_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              const Text(
                'Volume',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: accentColor,
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    value: volume,
                    min: 0.0,
                    max: 1.0,
                    onChanged: onVolumeChanged,
                  ),
                ),
              ),
              SizedBox(
                width: 38,
                child: Text(
                  '${(volume * 100).round()}%',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Soundscape Texture Intensity Control
          Row(
            children: [
              Icon(
                Icons.tune_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              const Text(
                'Intensity',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: accentColor.withOpacity(0.8),
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    value: intensity,
                    min: 0.1,
                    max: 1.0,
                    onChanged: onIntensityChanged,
                  ),
                ),
              ),
              SizedBox(
                width: 38,
                child: Text(
                  '${(intensity * 100).round()}%',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 8),

          // Binaural Entrainment Switch Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.headphones_rounded,
                    size: 16,
                    color: binauralEnabled ? accentColor : AppColors.textTertiary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Binaural Entrainment Sync',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: binauralEnabled ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onToggleBinaural,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: binauralEnabled
                        ? accentColor.withOpacity(0.18)
                        : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: binauralEnabled
                          ? accentColor.withOpacity(0.5)
                          : AppColors.borderSubtle,
                    ),
                  ),
                  child: Text(
                    binauralEnabled ? 'ACTIVE' : 'MUTED',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: binauralEnabled ? accentColor : AppColors.textTertiary,
                    ),
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
