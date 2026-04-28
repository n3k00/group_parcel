import 'bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/config/app_environment.dart';

void main() {
  const config = AppConfig(
    environment: AppEnvironment.dev,
    appName: 'Group Parcel Dev',
    showDebugBanner: true,
  );
  bootstrap(config);
}
