import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/qr_service.dart';
import '../data/local/preferences/app_preferences.dart';
import '../data/remote/firestore_parcel_data_source.dart';
import '../data/repositories/parcel_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/sync_repository.dart';
import '../data/repositories/town_repository.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import 'database_provider.dart';

final appPreferencesProvider = FutureProvider<AppPreferences>((ref) async {
  return AppPreferences.create();
});

final settingsRepositoryProvider = FutureProvider<SettingsRepository>((
  ref,
) async {
  final preferences = await ref.watch(appPreferencesProvider.future);
  final authService = ref.watch(authServiceProvider);
  return SettingsRepository(
    preferences,
    loginPhoneNumberProvider: () => authService.currentUser?.phoneNumber,
  );
});

final parcelRepositoryProvider = Provider<ParcelRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ParcelRepository(database.parcelsDao);
});

final townRepositoryProvider = Provider<TownRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return TownRepository(database.townsDao);
});

final qrServiceProvider = Provider<QrService>((ref) {
  return QrService();
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firestoreParcelDataSourceProvider = Provider<FirestoreParcelDataSource>((
  ref,
) {
  return FirestoreParcelDataSource(ref.watch(firestoreProvider));
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepository(
    ref.watch(parcelRepositoryProvider),
    ref.watch(firestoreParcelDataSourceProvider),
  );
});
