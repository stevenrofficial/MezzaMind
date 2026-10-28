import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_colors.dart';
import 'core/routing/app_router.dart';
import 'core/services/audio_engine_service.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/main_dashboard_screen.dart';
import 'features/google_flow/services/google_flow_service.dart';
import 'features/player/viewmodels/player_viewmodel.dart';
import 'features/settings/viewmodels/settings_viewmodel.dart';
import 'features/timer/viewmodels/timer_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize background notification audio player service (safe on supported platforms)
  if (!kIsWeb) {
    try {
      await JustAudioBackground.init(
        androidNotificationChannelId: 'com.mezzamind.mezzamind.channel.audio',
        androidNotificationChannelName: 'MezzaMind Ambient Playback',
        androidNotificationOngoing: true,
        androidNotificationIcon: 'mipmap/ic_launcher',
        notificationColor: AppColors.surface,
      );
    } catch (e) {
      debugPrint('MezzaMind: JustAudioBackground initialization notice: $e');
    }
  }

  // Initialize Storage
  final storageService = await StorageService.init();

  // Initialize Audio Engine Service
  final audioEngineService = AudioEngineService();
  await audioEngineService.init(
    initialVolume: storageService.getMasterVolume(),
    initialIntensity: storageService.getIntensity(),
  );

  runApp(
    MezzaMindApp(
      storageService: storageService,
      audioEngineService: audioEngineService,
    ),
  );
}

class MezzaMindApp extends StatelessWidget {
  final StorageService storageService;
  final AudioEngineService audioEngineService;

  const MezzaMindApp({
    super.key,
    required this.storageService,
    required this.audioEngineService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        Provider<AudioEngineService>.value(value: audioEngineService),
        ChangeNotifierProvider<PlayerViewModel>(
          create: (_) => PlayerViewModel(
            audioService: audioEngineService,
            storageService: storageService,
          ),
        ),
        ChangeNotifierProvider<TimerViewModel>(
          create: (_) => TimerViewModel(
            storageService: storageService,
            audioService: audioEngineService,
          ),
        ),
        ChangeNotifierProvider<SettingsViewModel>(
          create: (_) => SettingsViewModel(
            storageService: storageService,
          ),
        ),
        ChangeNotifierProvider<GoogleFlowService>(
          create: (_) => GoogleFlowService(
            storageService.rawPrefs,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'MezzaMind',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        initialRoute: AppRouter.dashboard,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const MainDashboardScreen(),
      ),
    );
  }
}
