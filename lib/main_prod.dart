import 'bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/config/app_environment.dart';

void main() {
  const config = AppConfig(
    environment: AppEnvironment.prod,
    appName: 'Group Parcel',
    showDebugBanner: false,
  );
  bootstrap(config);
}
