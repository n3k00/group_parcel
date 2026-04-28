import 'package:drift/drift.dart';

import '../local/database/app_database.dart';
import '../mappers/town_mapper.dart';
import '../models/town.dart';

class TownRepository {
  TownRepository(this._townsDao);

  final TownsDao _townsDao;

  Stream<List<TownModel>> watchSourceTowns() {
    return _townsDao
        .watchTownsByType(TownType.source)
        .map((rows) => rows.map(TownMapper.toModel).toList());
  }

  Stream<List<TownModel>> watchDestinationTowns() {
    return _townsDao
        .watchTownsByType(TownType.destination)
        .map((rows) => rows.map(TownMapper.toModel).toList());
  }

  Future<List<TownModel>> getSourceTowns() async {
    final rows = await _townsDao.getTownsByType(TownType.source);
    return rows.map(TownMapper.toModel).toList();
  }

  Future<List<TownModel>> getDestinationTowns() async {
    final rows = await _townsDao.getTownsByType(TownType.destination);
    return rows.map(TownMapper.toModel).toList();
  }

  Future<TownModel?> getSourceTownByName(String townName) async {
    final row = await _townsDao.getTownByName(
      townName: townName,
      type: TownType.source,
    );
    return row == null ? null : TownMapper.toModel(row);
  }

  Future<void> addSourceTown({
    required String townName,
    required String cityCode,
  }) {
    return _townsDao.insertTown(
      TownsCompanion.insert(
        townName: townName.trim(),
        type: TownType.source,
        cityCode: Value(cityCode.trim().toUpperCase()),
        sortOrder: Value.absent(),
      ),
    );
  }

  Future<void> addDestinationTown({required String townName}) {
    return _townsDao.insertTown(
      TownsCompanion.insert(
        townName: townName.trim(),
        type: TownType.destination,
        cityCode: const Value(null),
        sortOrder: Value.absent(),
      ),
    );
  }

  Future<void> deleteTown(int id) {
    return _townsDao.deleteTown(id);
  }
}
