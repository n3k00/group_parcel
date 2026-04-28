import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/town.dart';
import '../../../../providers/parcel_repository_provider.dart';

class TownSettingsState {
  const TownSettingsState({
    required this.sourceTowns,
    required this.destinationTowns,
    this.isSaving = false,
    this.errorMessage,
  });

  final List<TownModel> sourceTowns;
  final List<TownModel> destinationTowns;
  final bool isSaving;
  final String? errorMessage;

  TownSettingsState copyWith({
    List<TownModel>? sourceTowns,
    List<TownModel>? destinationTowns,
    bool? isSaving,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return TownSettingsState(
      sourceTowns: sourceTowns ?? this.sourceTowns,
      destinationTowns: destinationTowns ?? this.destinationTowns,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}

class TownSettingsNotifier extends AsyncNotifier<TownSettingsState> {
  @override
  Future<TownSettingsState> build() => _load();

  Future<TownSettingsState> _load() async {
    final repository = ref.read(townRepositoryProvider);
    final sourceTowns = await repository.getSourceTowns();
    final destinationTowns = await repository.getDestinationTowns();
    return TownSettingsState(
      sourceTowns: sourceTowns,
      destinationTowns: destinationTowns,
    );
  }

  Future<void> addSourceTown({
    required String townName,
    required String cityCode,
  }) async {
    final normalizedTownName = townName.trim();
    final normalizedCityCode = cityCode.trim().toUpperCase();
    if (normalizedTownName.isEmpty || normalizedCityCode.isEmpty) {
      state = AsyncData(
        (state.value ??
                const TownSettingsState(sourceTowns: [], destinationTowns: []))
            .copyWith(
              errorMessage: 'Source town name and city code are required.',
            ),
      );
      return;
    }

    final current = state.value;
    if (current != null &&
        current.sourceTowns.any(
          (town) =>
              town.townName == normalizedTownName ||
              town.cityCode == normalizedCityCode,
        )) {
      state = AsyncData(
        current.copyWith(
          errorMessage: 'Source town or city code already exists.',
        ),
      );
      return;
    }

    await ref
        .read(townRepositoryProvider)
        .addSourceTown(
          townName: normalizedTownName,
          cityCode: normalizedCityCode,
        );
    state = AsyncData(await _load());
  }

  Future<void> addDestinationTown({required String townName}) async {
    final normalizedTownName = townName.trim();
    if (normalizedTownName.isEmpty) {
      state = AsyncData(
        (state.value ??
                const TownSettingsState(sourceTowns: [], destinationTowns: []))
            .copyWith(errorMessage: 'Destination town name is required.'),
      );
      return;
    }

    final current = state.value;
    if (current != null &&
        current.destinationTowns.any(
          (town) => town.townName == normalizedTownName,
        )) {
      state = AsyncData(
        current.copyWith(errorMessage: 'Destination town already exists.'),
      );
      return;
    }

    await ref
        .read(townRepositoryProvider)
        .addDestinationTown(townName: normalizedTownName);
    state = AsyncData(await _load());
  }

  Future<void> deleteTown(int id) async {
    await ref.read(townRepositoryProvider).deleteTown(id);
    state = AsyncData(await _load());
  }
}

final townSettingsProvider =
    AsyncNotifierProvider<TownSettingsNotifier, TownSettingsState>(
      TownSettingsNotifier.new,
    );
