import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../timer/viewmodels/timer_viewmodel.dart';
import '../viewmodels/player_viewmodel.dart';
import '../widgets/mode_selector_pills.dart';
import '../widgets/soundscape_card.dart';
import '../widgets/visualizer_orb.dart';
import '../widgets/volume_intensity_controls.dart';

class PlayerScreen extends StatelessWidget {
  final VoidCallback onOpenTimer;
  final VoidCallback onOpenSettings;

  const PlayerScreen({
    super.key,
    required this.onOpenTimer,
    required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    final playerVM = context.watch<PlayerViewModel>();
    final timerVM = context.watch<TimerViewModel>();
    final soundscape = playerVM.currentSoundscape;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top App Bar / Distraction-free Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand / Logo
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: playerVM.isPlaying
                                ? soundscape.primaryColor
                                : AppColors.textTertiary,
                            boxShadow: playerVM.isPlaying
                                ? [
                                    BoxShadow(
                                      color: soundscape.primaryColor,
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'MEZZAMIND',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.2,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Quick Actions (Timer badge & Settings)
                    Row(
                      children: [
                        // Timer status badge
                        GestureDetector(
                          onTap: onOpenTimer,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: timerVM.isRunning
                                  ? AppColors.cyanAccent.withOpacity(0.15)
                                  : AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: timerVM.isRunning
                                    ? AppColors.cyanAccent.withOpacity(0.5)
                                    : AppColors.borderSubtle,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 14,
                                  color: timerVM.isRunning
                                      ? AppColors.cyanAccent
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  timerVM.isRunning
                                      ? timerVM.formattedTime
                                      : 'Timer',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.w600,
                                    color: timerVM.isRunning
                                        ? AppColors.cyanAccent
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Settings Icon
                        IconButton(
                          onPressed: onOpenSettings,
                          icon: const Icon(
                            Icons.settings_outlined,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Mode Selector Pills
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                child: ModeSelectorPills(
                  selectedMode: playerVM.selectedMode,
                  onModeSelected: (mode) => playerVM.selectMode(mode),
                ),
              ),
            ),

            // Central Pulsing Visualizer & Play Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: VisualizerOrb(
                    isPlaying: playerVM.isPlaying,
                    isLoading: playerVM.isLoading,
                    primaryColor: soundscape.primaryColor,
                    secondaryColor: soundscape.accentColor,
                    onTap: () => playerVM.togglePlayPause(),
                  ),
                ),
              ),
            ),

            // Soundscape Title, Frequency, and Subtitle
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      soundscape.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: soundscape.primaryColor.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: soundscape.primaryColor.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            soundscape.binauralHz.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                              color: soundscape.primaryColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•  ${soundscape.mode.title}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      soundscape.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                        height: 1.4,
                      ),
                    ),
                    if (playerVM.errorMessage != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.errorRed.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          playerVM.errorMessage!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.errorRed,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Volume & Intensity Controls
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: VolumeIntensityControls(
                  volume: playerVM.volume,
                  intensity: playerVM.intensity,
                  binauralEnabled: playerVM.binauralEnabled,
                  accentColor: soundscape.primaryColor,
                  onVolumeChanged: (val) => playerVM.setVolume(val),
                  onIntensityChanged: (val) => playerVM.setIntensity(val),
                  onToggleBinaural: () => playerVM.toggleBinaural(),
                ),
              ),
            ),

            // Soundscape Library Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${playerVM.selectedMode.title.toUpperCase()} PRESETS',
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textTertiary,
                      ),
                    ),
                    Text(
                      '${playerVM.currentModePresets.length} available',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Preset Cards List
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final preset = playerVM.currentModePresets[index];
                    final isSelected = preset.id == soundscape.id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SoundscapeCard(
                        soundscape: preset,
                        isSelected: isSelected,
                        isPlaying: playerVM.isPlaying,
                        onTap: () {
                          if (isSelected) {
                            playerVM.togglePlayPause();
                          } else {
                            playerVM.selectSoundscape(preset, autoPlay: true);
                          }
                        },
                      ),
                    );
                  },
                  childCount: playerVM.currentModePresets.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
