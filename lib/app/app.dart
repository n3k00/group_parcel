import 'package:flutter/material.dart';

import '../core/config/app_config.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../features/parcel/presentation/screens/home_screen.dart';
import 'router/app_router.dart';

class GroupApp extends StatelessWidget {
  const GroupApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: config.showDebugBanner,
      theme: AppTheme.light(),
      themeMode: ThemeMode.light,
      initialRoute: HomeScreen.routeName,
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
