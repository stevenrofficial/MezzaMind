import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../player/viewmodels/player_viewmodel.dart';
import '../models/timer_mode.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../widgets/timer_countdown_clock.dart';

class TimerScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const TimerScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final timerVM = context.watch<TimerViewModel>();
    final playerVM = context.watch<PlayerViewModel>();
    final accentColor = playerVM.currentSoundscape.primaryColor;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onBack != null)
                    IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    )
                  else
                    const SizedBox(width: 48),
                  const Text(
                    'FOCUS SESSION',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 16),

              // Mode toggle (Countdown vs Count-Up)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ModeToggleButton(
                      label: 'Countdown',
                      isSelected: timerVM.type == TimerType.countdown,
                      onTap: () => timerVM.setTimerType(TimerType.countdown),
                      accentColor: accentColor,
                    ),
                    _ModeToggleButton(
                      label: 'Open Sprint',
                      isSelected: timerVM.type == TimerType.countUp,
                      onTap: () => timerVM.setTimerType(TimerType.countUp),
                      accentColor: accentColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Animated Clock
              TimerCountdownClock(
                formattedTime: timerVM.formattedTime,
                progress: timerVM.progress,
                status: timerVM.status,
                type: timerVM.type,
                accentColor: accentColor,
              ),

              const SizedBox(height: 28),

              // Presets (Only in countdown mode)
              if (timerVM.type == TimerType.countdown) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: TimerViewModel.presets.map((preset) {
                    final isSelected =
                        timerVM.selectedPreset.minutes == preset.minutes;
                    return ChoiceChip(
                      label: Text(preset.label),
                      selected: isSelected,
                      onSelected: timerVM.isRunning
                          ? null
                          : (_) => timerVM.selectPreset(preset),
                      selectedColor: accentColor.withOpacity(0.2),
                      backgroundColor: AppColors.surfaceElevated,
                      side: BorderSide(
                        color: isSelected
                            ? accentColor.withOpacity(0.6)
                            : AppColors.borderSubtle,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 6),
                Text(
                  timerVM.selectedPreset.tag,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],

              const SizedBox(height: 36),

              // Controls: Start / Pause / Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Reset Button
                  IconButton(
                    onPressed: timerVM.status != TimerStatus.idle
                        ? () => timerVM.reset()
                        : null,
                    icon: const Icon(Icons.refresh_rounded),
                    iconSize: 28,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 20),

                  // Main Play/Pause Button
                  GestureDetector(
                    onTap: () {
                      if (timerVM.status == TimerStatus.running) {
                        timerVM.pause();
                      } else if (timerVM.status == TimerStatus.paused) {
                        timerVM.resume();
                      } else {
                        timerVM.start();
                      }
                    },
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.4),
                            blurRadius: 18,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        timerVM.status == TimerStatus.running
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 38,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Soundscape sync indicator
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceElevated,
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Icon(
                      playerVM.isPlaying
                          ? Icons.music_note_rounded
                          : Icons.music_off_rounded,
                      size: 20,
                      color: playerVM.isPlaying
                          ? accentColor
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Audio fade out toggle card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.volume_down_rounded,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Auto-Fade Soundscape',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Gently silence audio when timer finishes',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: timerVM.fadeAudioOnComplete,
                      activeColor: accentColor,
                      onChanged: (_) => timerVM.toggleFadeAudioOnComplete(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color accentColor;

  const _ModeToggleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withOpacity(0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? accentColor.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
