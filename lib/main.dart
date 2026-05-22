import 'bootstrap.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  await bootstrap(AppConfig.fromEnvironment());
}
