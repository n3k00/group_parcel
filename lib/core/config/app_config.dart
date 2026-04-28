import 'app_environment.dart';

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.showDebugBanner,
  });

  final AppEnvironment environment;
  final String appName;
  final bool showDebugBanner;

  bool get isDev => environment == AppEnvironment.dev;

  bool get isProd => environment == AppEnvironment.prod;

  static AppConfig fromEnvironment() {
    final environment = AppEnvironment.fromValue(
      const String.fromEnvironment('APP_ENV', defaultValue: 'prod'),
    );
    final appName = const String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Group Parcel',
    );

    return AppConfig(
      environment: environment,
      appName: appName,
      showDebugBanner: environment == AppEnvironment.dev,
    );
  }
}
