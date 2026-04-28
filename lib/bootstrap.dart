import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

void bootstrap(AppConfig config) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: GroupApp(config: config)));
}
