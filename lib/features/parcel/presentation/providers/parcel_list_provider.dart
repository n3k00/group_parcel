import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/enums/parcel_status.dart';
import '../../../../data/models/parcel.dart';
import '../../../../providers/parcel_repository_provider.dart';

class ParcelListFilterState {
  const ParcelListFilterState({
    this.query = '',
    this.status,
    this.startDate,
    this.endDate,
  });

  final String query;
  final ParcelStatus? status;
  final DateTime? startDate;
  final DateTime? endDate;

  ParcelListFilterState copyWith({
    String? query,
    ParcelStatus? status,
    bool clearStatus = false,
    DateTime? startDate,
    bool clearStartDate = false,
    DateTime? endDate,
    bool clearEndDate = false,
  }) {
    return ParcelListFilterState(
      query: query ?? this.query,
      status: clearStatus ? null : status ?? this.status,
      startDate: clearStartDate ? null : startDate ?? this.startDate,
      endDate: clearEndDate ? null : endDate ?? this.endDate,
    );
  }
}

class ParcelListFilterNotifier extends Notifier<ParcelListFilterState> {
  @override
  ParcelListFilterState build() => const ParcelListFilterState();

  void updateQuery(String value) {
    state = state.copyWith(query: value);
  }

  void updateStatus(ParcelStatus? value) {
    state = state.copyWith(status: value, clearStatus: value == null);
  }

  void updateDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    state = state.copyWith(
      startDate: startDate,
      clearStartDate: startDate == null,
      endDate: endDate,
      clearEndDate: endDate == null,
    );
  }

  void clearFilters() {
    state = const ParcelListFilterState();
  }
}

final parcelListFilterProvider =
    NotifierProvider.autoDispose<ParcelListFilterNotifier, ParcelListFilterState>(
  ParcelListFilterNotifier.new,
);

final parcelListProvider = StreamProvider.autoDispose<List<ParcelModel>>((ref) {
  final repository = ref.watch(parcelRepositoryProvider);
  final filters = ref.watch(parcelListFilterProvider);

  return repository.watchParcels().map(
        (parcels) =>
            parcels.where((parcel) => _matchesFilter(parcel, filters)).toList(),
      );
});

bool _matchesFilter(ParcelModel parcel, ParcelListFilterState filters) {
  if (filters.status != null && parcel.status != filters.status) {
    return false;
  }

  if (filters.startDate != null && parcel.createdAt.isBefore(filters.startDate!)) {
    return false;
  }

  if (filters.endDate != null && parcel.createdAt.isAfter(filters.endDate!)) {
    return false;
  }

  final query = filters.query.trim().toLowerCase();
  if (query.isEmpty) {
    return true;
  }

  return _contains(parcel.trackingId, query) ||
      _contains(parcel.receiverName, query) ||
      _contains(parcel.receiverPhone, query);
}

bool _contains(String value, String query) {
  return value.toLowerCase().contains(query);
}
