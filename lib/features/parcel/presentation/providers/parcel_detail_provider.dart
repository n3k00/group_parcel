import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/parcel.dart';
import '../../../../providers/parcel_repository_provider.dart';

final parcelDetailByIdProvider =
    FutureProvider.autoDispose.family<ParcelModel?, int>((ref, id) {
  return ref.watch(parcelRepositoryProvider).getParcel(id);
});

final parcelDetailByTrackingIdProvider =
    FutureProvider.autoDispose.family<ParcelModel?, String>((ref, trackingId) {
  return ref.watch(parcelRepositoryProvider).getParcelByTrackingId(trackingId);
});
