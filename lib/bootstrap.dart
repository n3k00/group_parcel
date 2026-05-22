import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  String? firebaseInitializationError;

  try {
    await Firebase.initializeApp();
  } catch (error) {
    firebaseInitializationError =
        'Firebase initialization failed. Add a valid Android Firebase configuration before using login.\n$error';
  }

  runApp(
    ProviderScope(
      child: GroupApp(
        config: config,
        firebaseInitializationError: firebaseInitializationError,
      ),
    ),
  );
}
