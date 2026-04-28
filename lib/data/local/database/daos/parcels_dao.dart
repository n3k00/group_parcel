part of '../app_database.dart';

@DriftAccessor(tables: [Parcels])
class ParcelsDao extends DatabaseAccessor<AppDatabase> with _$ParcelsDaoMixin {
  ParcelsDao(super.db);

  Future<int> insertParcel(ParcelsCompanion entry) {
    return into(parcels).insert(entry);
  }

  Future<bool> updateParcel(ParcelsCompanion entry) {
    return update(parcels).replace(entry);
  }

  Future<int> deleteParcelById(int id) {
    return (delete(parcels)..where((table) => table.id.equals(id))).go();
  }

  Future<Parcel?> getParcelById(int id) {
    return (select(parcels)..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<Parcel?> getParcelByTrackingId(String trackingId) {
    return (select(parcels)..where((table) => table.trackingId.equals(trackingId)))
        .getSingleOrNull();
  }

  Future<List<Parcel>> getAllParcels() {
    final query = select(parcels)
      ..orderBy([
        (table) => OrderingTerm(
              expression: table.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);
    return query.get();
  }

  Stream<List<Parcel>> watchAllParcels() {
    final query = select(parcels)
      ..orderBy([
        (table) => OrderingTerm(
              expression: table.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);
    return query.watch();
  }

  Future<List<Parcel>> searchParcels(String query) {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) {
      return getAllParcels();
    }

    final pattern = '%$trimmed%';
    final searchQuery = select(parcels)
      ..where(
        (table) =>
            table.trackingId.lower().like(pattern) |
            table.senderName.lower().like(pattern) |
            table.senderPhone.lower().like(pattern) |
            table.receiverName.lower().like(pattern) |
            table.receiverPhone.lower().like(pattern),
      )
      ..orderBy([
        (table) => OrderingTerm(
              expression: table.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);

    return searchQuery.get();
  }

  Future<List<Parcel>> filterParcelsByStatus(ParcelStatus status) {
    final query = select(parcels)
      ..where((table) => table.status.equalsValue(status))
      ..orderBy([
        (table) => OrderingTerm(
              expression: table.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);

    return query.get();
  }

  Future<List<Parcel>> filterParcelsByDate({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final query = select(parcels);

    if (startDate != null) {
      query.where((table) => table.createdAt.isBiggerOrEqualValue(startDate));
    }

    if (endDate != null) {
      query.where((table) => table.createdAt.isSmallerOrEqualValue(endDate));
    }

    query.orderBy([
      (table) => OrderingTerm(
            expression: table.createdAt,
            mode: OrderingMode.desc,
          ),
    ]);

    return query.get();
  }

  Future<int> countParcelsCreatedOnForCounter({
    required DateTime startDate,
    required DateTime endDate,
    required String cityCode,
    required String accountCode,
  }) async {
    final countExpression = parcels.id.count();
    final query = selectOnly(parcels)
      ..addColumns([countExpression])
      ..where(parcels.createdAt.isBiggerOrEqualValue(startDate))
      ..where(parcels.createdAt.isSmallerOrEqualValue(endDate))
      ..where(parcels.cityCode.equals(cityCode))
      ..where(parcels.accountCode.equals(accountCode));

    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }
}
