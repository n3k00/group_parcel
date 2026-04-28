part of '../app_database.dart';

class Towns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get townName => text().named('town_name')();
  TextColumn get type => textEnum<TownType>().named('type')();
  TextColumn get cityCode => text().named('city_code').nullable()();
  IntColumn get sortOrder =>
      integer().named('sort_order').withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {type, townName},
  ];

  @override
  List<String> get customConstraints => const [
    "CHECK ((type = 'source' AND city_code IS NOT NULL AND length(trim(city_code)) > 0) OR (type = 'destination' AND city_code IS NULL))",
  ];
}
