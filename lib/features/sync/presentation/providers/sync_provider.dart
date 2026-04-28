import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/repository_provider.dart';

class SyncController {
  SyncController(this._ref);

  final Ref _ref;

  String status = 'idle';
  String message = '';

  Future<void> syncNow() async {
    status = 'pending';
    message = await _ref.read(syncRepositoryProvider).syncNow();
    status = 'synced';
  }
}

final syncProvider = Provider.autoDispose<SyncController>((ref) {
  return SyncController(ref);
});
