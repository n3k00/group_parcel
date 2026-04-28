part of '../app_database.dart';

@DriftAccessor(tables: [Towns])
class TownsDao extends DatabaseAccessor<AppDatabase> with _$TownsDaoMixin {
  TownsDao(super.db);

  Future<List<Town>> getTownsByType(TownType type) {
    final query = select(towns)
      ..where((table) => table.type.equalsValue(type))
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.sortOrder, mode: OrderingMode.asc),
        (table) => OrderingTerm(
          expression: table.townName.lower(),
          mode: OrderingMode.asc,
        ),
      ]);
    return query.get();
  }

  Stream<List<Town>> watchTownsByType(TownType type) {
    final query = select(towns)
      ..where((table) => table.type.equalsValue(type))
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.sortOrder, mode: OrderingMode.asc),
        (table) => OrderingTerm(
          expression: table.townName.lower(),
          mode: OrderingMode.asc,
        ),
      ]);
    return query.watch();
  }

  Future<Town?> getTownByName({
    required String townName,
    required TownType type,
  }) {
    return (select(towns)..where(
          (table) =>
              table.type.equalsValue(type) &
              table.townName.equals(townName.trim()),
        ))
        .getSingleOrNull();
  }

  Future<void> insertTown(TownsCompanion entry) async {
    await into(towns).insert(entry, mode: InsertMode.insertOrIgnore);
  }

  Future<void> deleteTown(int id) async {
    await (delete(towns)..where((table) => table.id.equals(id))).go();
  }
}
