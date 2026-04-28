import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/data/local/database/app_database.dart';
import 'package:group_mobile/data/models/enums/payment_status.dart';
import 'package:group_mobile/data/models/enums/parcel_status.dart';
import 'package:group_mobile/data/models/parcel.dart';
import 'package:group_mobile/data/repositories/parcel_repository.dart';

void main() {
  late AppDatabase database;
  late ParcelRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = ParcelRepository(database.parcelsDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates a parcel locally with offline-safe defaults', () async {
    final id = await repository.createParcel(
      _buildParcel(trackingId: 'TGI-A1-250317-0001'),
    );
    final saved = await repository.getParcel(id);

    expect(saved, isNotNull);
    expect(saved!.trackingId, 'TGI-A1-250317-0001');
    expect(saved.status, ParcelStatus.received);
    expect(saved.syncStatus.name, 'pending');
    expect(saved.syncedAt, isNull);
    expect(saved.cashAdvance, 0);
    expect(saved.parcelImagePath, 'C:/parcel-images/sample.jpg');
  });

  test('updates a parcel and refreshes updatedAt', () async {
    final id = await repository.createParcel(
      _buildParcel(trackingId: 'TGI-A1-250317-0002'),
    );
    final saved = await repository.getParcel(id);
    final originalUpdatedAt = saved!.updatedAt;

    await Future<void>.delayed(const Duration(seconds: 1));

    final updated = saved.copyWith(
      id: id,
      receiverName: 'Updated Receiver',
      totalCharges: 9500,
      status: ParcelStatus.arrived,
    );
    await repository.updateParcel(updated);
    final reloaded = await repository.getParcel(id);

    expect(reloaded, isNotNull);
    expect(reloaded!.receiverName, 'Updated Receiver');
    expect(reloaded.totalCharges, 9500);
    expect(reloaded.status, ParcelStatus.arrived);
    expect(reloaded.updatedAt.isAfter(originalUpdatedAt), isTrue);
  });

  test('fetches a parcel by tracking ID', () async {
    await repository.createParcel(
      _buildParcel(trackingId: 'TGI-A1-250317-0003'),
    );

    final saved = await repository.getParcelByTrackingId('TGI-A1-250317-0003');

    expect(saved, isNotNull);
    expect(saved!.receiverName, 'Ma Su');
  });

  test('counts parcels by city code, account code, and date for tracking IDs', () async {
    await repository.createParcel(
      _buildParcel(
        trackingId: 'TGI-A1-250317-0001',
        cityCode: 'TGI',
        accountCode: 'A1',
      ),
    );
    await repository.createParcel(
      _buildParcel(
        trackingId: 'TGI-A1-250317-0002',
        cityCode: 'TGI',
        accountCode: 'A1',
      ),
    );
    await repository.createParcel(
      _buildParcel(
        trackingId: 'LSO-A1-250317-0001',
        cityCode: 'LSO',
        accountCode: 'A1',
      ),
    );
    await repository.createParcel(
      _buildParcel(
        trackingId: 'TGI-B2-250317-0001',
        cityCode: 'TGI',
        accountCode: 'B2',
      ),
    );
    await repository.createParcel(
      _buildParcel(
        trackingId: 'TGI-A1-250318-0001',
        cityCode: 'TGI',
        accountCode: 'A1',
      ),
    );

    final count = await repository.countParcelsCreatedOnForCounter(
      DateTime.now(),
      'TGI',
      'A1',
    );

    expect(count, 3);
  });
}

ParcelModel _buildParcel({
  required String trackingId,
  String cityCode = 'TGI',
  String accountCode = 'A1',
  DateTime? now,
}) {
  return ParcelModel.create(
    trackingId: trackingId,
    fromTown: 'Taunggyi',
    toTown: 'Kalaw',
    cityCode: cityCode,
    accountCode: accountCode,
    senderName: 'Ko Aung',
    senderPhone: '0912345678',
    receiverName: 'Ma Su',
    receiverPhone: '0998765432',
    parcelType: 'Document',
    numberOfParcels: 1,
    totalCharges: 7000,
    paymentStatus: PaymentStatus.paid,
    parcelImagePath: 'C:/parcel-images/sample.jpg',
    remark: 'Handle carefully',
    now: now ?? DateTime(2025, 3, 17, 9, 0),
  );
}
