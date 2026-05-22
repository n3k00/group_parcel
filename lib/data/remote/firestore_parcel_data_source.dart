import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/enums/parcel_status.dart';
import '../models/enums/payment_status.dart';
import '../models/enums/sync_status.dart';
import '../models/parcel.dart';

abstract class ParcelRemoteDataSource {
  Future<ParcelModel?> fetchParcel(String trackingId);
  Future<List<ParcelModel>> fetchAllParcels();
  Future<void> upsertParcel(ParcelModel parcel);
}

class FirestoreParcelDataSource implements ParcelRemoteDataSource {
  FirestoreParcelDataSource(this._firestore);

  static const _collectionName = 'parcels';

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _parcels =>
      _firestore.collection(_collectionName);

  @override
  Future<ParcelModel?> fetchParcel(String trackingId) async {
    final snapshot = await _parcels.doc(trackingId).get();
    if (!snapshot.exists) {
      return null;
    }

    return _fromDocument(snapshot);
  }

  @override
  Future<List<ParcelModel>> fetchAllParcels() async {
    final snapshot = await _parcels.orderBy('updatedAt', descending: true).get();
    return snapshot.docs.map(_fromDocument).toList();
  }

  @override
  Future<void> upsertParcel(ParcelModel parcel) {
    return _parcels.doc(parcel.trackingId).set(_toDocument(parcel));
  }

  Map<String, dynamic> _toDocument(ParcelModel parcel) {
    return {
      'trackingId': parcel.trackingId,
      'createdAt': Timestamp.fromDate(parcel.createdAt),
      'fromTown': parcel.fromTown,
      'toTown': parcel.toTown,
      'cityCode': parcel.cityCode,
      'accountCode': parcel.accountCode,
      'senderName': parcel.senderName,
      'senderPhone': parcel.senderPhone,
      'receiverName': parcel.receiverName,
      'receiverPhone': parcel.receiverPhone,
      'ledgerId': parcel.ledgerId,
      'parcelType': parcel.parcelType,
      'numberOfParcels': parcel.numberOfParcels,
      'totalCharges': parcel.totalCharges,
      'paymentStatus': parcel.paymentStatus.value,
      'cashAdvance': parcel.cashAdvance,
      'remark': parcel.remark,
      'status': parcel.status.value,
      'arrivedAt': parcel.arrivedAt == null
          ? null
          : Timestamp.fromDate(parcel.arrivedAt!),
      'claimedAt': parcel.claimedAt == null
          ? null
          : Timestamp.fromDate(parcel.claimedAt!),
      'updatedAt': Timestamp.fromDate(parcel.updatedAt),
    };
  }

  ParcelModel _fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    DateTime readTimestamp(String key) {
      final value = data[key];
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      return DateTime.parse(value as String);
    }

    DateTime? readNullableTimestamp(String key) {
      final value = data[key];
      if (value == null) {
        return null;
      }
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      return DateTime.parse(value as String);
    }

    return ParcelModel(
      trackingId: (data['trackingId'] as String?) ?? snapshot.id,
      createdAt: readTimestamp('createdAt'),
      fromTown: data['fromTown'] as String,
      toTown: data['toTown'] as String,
      cityCode: data['cityCode'] as String,
      accountCode: data['accountCode'] as String,
      senderName: data['senderName'] as String,
      senderPhone: data['senderPhone'] as String,
      receiverName: data['receiverName'] as String,
      receiverPhone: data['receiverPhone'] as String,
      ledgerId: data['ledgerId'] as String?,
      parcelType: data['parcelType'] as String,
      numberOfParcels: (data['numberOfParcels'] as num).toInt(),
      totalCharges: (data['totalCharges'] as num).toDouble(),
      paymentStatus: PaymentStatus.fromValue(data['paymentStatus'] as String),
      cashAdvance: ((data['cashAdvance'] as num?) ?? 0).toDouble(),
      remark: data['remark'] as String?,
      status: ParcelStatus.fromValue(
        (data['status'] as String?) ?? ParcelStatus.received.value,
      ),
      syncStatus: SyncStatus.synced,
      syncedAt: DateTime.now(),
      arrivedAt: readNullableTimestamp('arrivedAt'),
      claimedAt: readNullableTimestamp('claimedAt'),
      updatedAt: readTimestamp('updatedAt'),
    );
  }
}
