part of '../app_database.dart';

@DriftAccessor(tables: [ParcelEvents])
class ParcelEventsDao extends DatabaseAccessor<AppDatabase>
    with _$ParcelEventsDaoMixin {
  ParcelEventsDao(super.db);
}
