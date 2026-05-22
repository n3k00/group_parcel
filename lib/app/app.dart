import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/config/app_config.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/parcel/presentation/screens/home_screen.dart';
import 'router/app_router.dart';

class GroupApp extends StatelessWidget {
  const GroupApp({
    super.key,
    required this.config,
    this.firebaseInitializationError,
  });

  final AppConfig config;
  final String? firebaseInitializationError;

  @override
  Widget build(BuildContext context) {
    final firebaseError = firebaseInitializationError;
    final initialRoute = firebaseError != null
        ? null
        : FirebaseAuth.instance.currentUser == null
        ? LoginScreen.routeName
        : HomeScreen.routeName;

    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: config.showDebugBanner,
      theme: AppTheme.light(),
      themeMode: ThemeMode.light,
      initialRoute: initialRoute,
      home: firebaseError == null
          ? null
          : Scaffold(
              appBar: AppBar(title: const Text('Firebase Setup Required')),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(firebaseError),
                ),
              ),
            ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        if (!config.isDev || child == null) {
          return child ?? const SizedBox.shrink();
        }

        return Banner(
          message: AppConstants.devBannerLabel,
          location: BannerLocation.topEnd,
          child: child,
        );
      },
    );
  }
}
