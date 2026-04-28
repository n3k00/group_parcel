import '../local/database/app_database.dart';
import '../models/town.dart';

class TownMapper {
  const TownMapper._();

  static TownModel toModel(Town row) {
    return TownModel(
      id: row.id,
      townName: row.townName,
      type: row.type,
      cityCode: row.cityCode,
      sortOrder: row.sortOrder,
    );
  }
}
