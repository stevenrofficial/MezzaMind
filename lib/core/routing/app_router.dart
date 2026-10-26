import 'package:flutter/material.dart';
import '../../features/dashboard/main_dashboard_screen.dart';
import '../../features/player/views/player_screen.dart';
import '../../features/settings/views/settings_screen.dart';
import '../../features/timer/views/timer_screen.dart';

class AppRouter {
  static const String dashboard = '/';
  static const String player = '/player';
  static const String timer = '/timer';
  static const String settings = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const MainDashboardScreen());
      case player:
        return MaterialPageRoute(
          builder: (ctx) => PlayerScreen(
            onOpenTimer: () => Navigator.pushNamed(ctx, timer),
            onOpenSettings: () => Navigator.pushNamed(ctx, settings.name!),
          ),
        );
      case timer:
        return MaterialPageRoute(
          builder: (ctx) => TimerScreen(
            onBack: () => Navigator.pop(ctx),
          ),
        );
      case AppRouter.settings:
        return MaterialPageRoute(
          builder: (ctx) => SettingsScreen(
            onBack: () => Navigator.pop(ctx),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const MainDashboardScreen());
    }
  }
}
