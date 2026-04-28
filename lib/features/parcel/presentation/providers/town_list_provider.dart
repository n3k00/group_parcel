import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/town.dart';
import '../../../../providers/parcel_repository_provider.dart';

final sourceTownListProvider = StreamProvider<List<TownModel>>((ref) {
  return ref.watch(townRepositoryProvider).watchSourceTowns();
});

final destinationTownListProvider = StreamProvider<List<TownModel>>((ref) {
  return ref.watch(townRepositoryProvider).watchDestinationTowns();
});
