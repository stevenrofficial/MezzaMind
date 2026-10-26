import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../player/viewmodels/player_viewmodel.dart';
import '../player/views/player_screen.dart';
import '../player/widgets/persistent_mini_player.dart';
import '../settings/viewmodels/settings_viewmodel.dart';
import '../settings/views/settings_screen.dart';
import '../timer/views/timer_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerVM = context.watch<PlayerViewModel>();
    final settingsVM = context.watch<SettingsViewModel>();

    final backgroundColor = settingsVM.oledPureBlack
        ? Colors.black
        : AppColors.background;

    final pages = [
      PlayerScreen(
        onOpenTimer: () => _switchTab(1),
        onOpenSettings: () => _switchTab(2),
      ),
      TimerScreen(
        onBack: () => _switchTab(0),
      ),
      SettingsScreen(
        onBack: () => _switchTab(0),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Current Page
          IndexedStack(
            index: _currentIndex,
            children: pages,
          ),

          // Persistent Floating Mini-Player bar (shown when browsing Timer or Settings)
          if (_currentIndex != 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: PersistentMiniPlayer(
                soundscape: playerVM.currentSoundscape,
                isPlaying: playerVM.isPlaying,
                isLoading: playerVM.isLoading,
                onTogglePlay: () => playerVM.togglePlayPause(),
                onTap: () => _switchTab(0),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.borderSubtle, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _switchTab,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: playerVM.currentSoundscape.primaryColor,
          unselectedItemColor: AppColors.textTertiary,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq_rounded),
              activeIcon: Icon(Icons.graphic_eq_rounded),
              label: 'Soundscapes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer_outlined),
              activeIcon: Icon(Icons.timer_rounded),
              label: 'Focus Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tune_rounded),
              activeIcon: Icon(Icons.tune_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
