import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/default_towns.dart';
import '../../models/enums/parcel_status.dart';
import '../../models/enums/payment_status.dart';
import '../../models/enums/sync_status.dart';
import '../../models/town.dart';

part 'tables/parcels_table.dart';
part 'tables/parcel_events_table.dart';
part 'tables/towns_table.dart';
part 'daos/parcels_dao.dart';
part 'daos/parcel_events_dao.dart';
part 'daos/towns_dao.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [Parcels, ParcelEvents, Towns],
  daos: [ParcelsDao, ParcelEventsDao, TownsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _seedDefaultTowns();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(towns);
        await _seedDefaultTowns();
      }
      if (from < 3) {
        await migrator.addColumn(parcels, parcels.ledgerId);
      }
    },
  );

  Future<void> _seedDefaultTowns() async {
    final companions = DefaultTowns.all
        .map(
          (town) => TownsCompanion.insert(
            townName: town.townName,
            type: town.type,
            cityCode: Value(town.cityCode),
            sortOrder: Value(town.sortOrder),
          ),
        )
        .toList();

    await batch((batch) {
      batch.insertAll(towns, companions, mode: InsertMode.insertOrIgnore);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final file = File(p.join(documentsDirectory.path, 'groupparcel.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
