import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/models/call_log_model.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/otp_screen.dart';
import 'features/call_logs/screens/call_detail_screen.dart';
import 'features/call_logs/screens/call_logs_screen.dart';
import 'features/permissions/screens/permissions_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/sync/services/background_sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Init background sync manager
  await BackgroundSyncManager.initialize();

  // Determine start route
  final prefs = await SharedPreferences.getInstance();
  final onboardingDone =
      prefs.getBool(AppConstants.prefOnboardingComplete) ?? false;
  final isLoggedIn = prefs.getString(AppConstants.prefAuthUser) != null;

  // If logged in but onboarding never completed (e.g. fresh install edge-case),
  // send back to permissions so READ_CALL_LOG is granted before home loads.
  final String initialRoute;
  if (!onboardingDone) {
    initialRoute = AppRoutes.permissions;
  } else if (!isLoggedIn) {
    initialRoute = AppRoutes.login;
  } else {
    initialRoute = AppRoutes.home;
  }

  runApp(
    ProviderScope(
      child: LmsCallApp(initialRoute: initialRoute),
    ),
  );
}

class LmsCallApp extends StatelessWidget {
  final String initialRoute;

  const LmsCallApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: initialRoute,
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.permissions:
        return _fadeRoute(const PermissionsScreen(), settings);

      case AppRoutes.login:
        return _fadeRoute(const LoginScreen(), settings);

      case AppRoutes.otpVerify:
        final args = settings.arguments as Map<String, dynamic>;
        return _slideRoute(
          OtpScreen(
            mobileNumber: args['mobile'] as String,
            debugCode: args['debugCode'] as String?,
          ),
          settings,
        );

      case AppRoutes.home:
        return _fadeRoute(const CallLogsScreen(), settings);

      case AppRoutes.callDetail:
        final group = settings.arguments as CallLogGroup;
        return _slideRoute(
          CallDetailScreen(group: group),
          settings,
        );

      case AppRoutes.settings:
        return _slideRoute(const SettingsScreen(), settings);

      default:
        return _fadeRoute(const LoginScreen(), settings);
    }
  }

  PageRoute<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

  PageRoute<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final offset = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
        return SlideTransition(position: offset, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
