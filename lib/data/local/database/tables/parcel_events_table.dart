part of '../app_database.dart';

class ParcelEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parcelId =>
      integer().named('parcel_id').references(Parcels, #id, onDelete: KeyAction.cascade)();
  TextColumn get eventLabel => text().named('event_label')();
  DateTimeColumn get eventTime => dateTime().named('event_time')();
}
