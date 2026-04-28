part of '../app_database.dart';

class Parcels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get trackingId => text().named('tracking_id')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  TextColumn get fromTown => text().named('from_town')();
  TextColumn get toTown => text().named('to_town')();
  TextColumn get cityCode => text().named('city_code')();
  TextColumn get accountCode => text().named('account_code')();
  TextColumn get senderName => text().named('sender_name')();
  TextColumn get senderPhone => text().named('sender_phone')();
  TextColumn get receiverName => text().named('receiver_name')();
  TextColumn get receiverPhone => text().named('receiver_phone')();
  TextColumn get parcelType => text().named('parcel_type')();
  IntColumn get numberOfParcels => integer().named('number_of_parcels')();
  RealColumn get totalCharges => real().named('total_charges')();
  TextColumn get paymentStatus => textEnum<PaymentStatus>().named('payment_status')();
  RealColumn get cashAdvance =>
      real().named('cash_advance').withDefault(const Constant(0))();
  TextColumn get parcelImagePath => text().named('parcel_image_path').nullable()();
  TextColumn get remark => text().nullable()();
  TextColumn get status =>
      textEnum<ParcelStatus>().withDefault(const Constant('received'))();
  TextColumn get syncStatus =>
      textEnum<SyncStatus>().named('sync_status').withDefault(const Constant('pending'))();
  DateTimeColumn get syncedAt => dateTime().named('synced_at').nullable()();
  DateTimeColumn get arrivedAt => dateTime().named('arrived_at').nullable()();
  DateTimeColumn get claimedAt => dateTime().named('claimed_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  List<Set<Column>> get uniqueKeys => [
        {trackingId},
      ];

  @override
  List<String> get customConstraints => const [
        'CHECK (number_of_parcels > 0)',
        'CHECK (total_charges >= 0)',
        'CHECK (cash_advance >= 0)',
      ];
}
