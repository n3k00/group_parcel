// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ParcelsTable extends Parcels with TableInfo<$ParcelsTable, Parcel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trackingIdMeta = const VerificationMeta(
    'trackingId',
  );
  @override
  late final GeneratedColumn<String> trackingId = GeneratedColumn<String>(
    'tracking_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromTownMeta = const VerificationMeta(
    'fromTown',
  );
  @override
  late final GeneratedColumn<String> fromTown = GeneratedColumn<String>(
    'from_town',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toTownMeta = const VerificationMeta('toTown');
  @override
  late final GeneratedColumn<String> toTown = GeneratedColumn<String>(
    'to_town',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityCodeMeta = const VerificationMeta(
    'cityCode',
  );
  @override
  late final GeneratedColumn<String> cityCode = GeneratedColumn<String>(
    'city_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountCodeMeta = const VerificationMeta(
    'accountCode',
  );
  @override
  late final GeneratedColumn<String> accountCode = GeneratedColumn<String>(
    'account_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderPhoneMeta = const VerificationMeta(
    'senderPhone',
  );
  @override
  late final GeneratedColumn<String> senderPhone = GeneratedColumn<String>(
    'sender_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverNameMeta = const VerificationMeta(
    'receiverName',
  );
  @override
  late final GeneratedColumn<String> receiverName = GeneratedColumn<String>(
    'receiver_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverPhoneMeta = const VerificationMeta(
    'receiverPhone',
  );
  @override
  late final GeneratedColumn<String> receiverPhone = GeneratedColumn<String>(
    'receiver_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parcelTypeMeta = const VerificationMeta(
    'parcelType',
  );
  @override
  late final GeneratedColumn<String> parcelType = GeneratedColumn<String>(
    'parcel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfParcelsMeta = const VerificationMeta(
    'numberOfParcels',
  );
  @override
  late final GeneratedColumn<int> numberOfParcels = GeneratedColumn<int>(
    'number_of_parcels',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalChargesMeta = const VerificationMeta(
    'totalCharges',
  );
  @override
  late final GeneratedColumn<double> totalCharges = GeneratedColumn<double>(
    'total_charges',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentStatus, String>
  paymentStatus = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PaymentStatus>($ParcelsTable.$converterpaymentStatus);
  static const VerificationMeta _cashAdvanceMeta = const VerificationMeta(
    'cashAdvance',
  );
  @override
  late final GeneratedColumn<double> cashAdvance = GeneratedColumn<double>(
    'cash_advance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _parcelImagePathMeta = const VerificationMeta(
    'parcelImagePath',
  );
  @override
  late final GeneratedColumn<String> parcelImagePath = GeneratedColumn<String>(
    'parcel_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
    'remark',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ParcelStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('received'),
      ).withConverter<ParcelStatus>($ParcelsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($ParcelsTable.$convertersyncStatus);
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _arrivedAtMeta = const VerificationMeta(
    'arrivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> arrivedAt = GeneratedColumn<DateTime>(
    'arrived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimedAtMeta = const VerificationMeta(
    'claimedAt',
  );
  @override
  late final GeneratedColumn<DateTime> claimedAt = GeneratedColumn<DateTime>(
    'claimed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trackingId,
    createdAt,
    fromTown,
    toTown,
    cityCode,
    accountCode,
    senderName,
    senderPhone,
    receiverName,
    receiverPhone,
    parcelType,
    numberOfParcels,
    totalCharges,
    paymentStatus,
    cashAdvance,
    parcelImagePath,
    remark,
    status,
    syncStatus,
    syncedAt,
    arrivedAt,
    claimedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parcels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Parcel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tracking_id')) {
      context.handle(
        _trackingIdMeta,
        trackingId.isAcceptableOrUnknown(data['tracking_id']!, _trackingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackingIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('from_town')) {
      context.handle(
        _fromTownMeta,
        fromTown.isAcceptableOrUnknown(data['from_town']!, _fromTownMeta),
      );
    } else if (isInserting) {
      context.missing(_fromTownMeta);
    }
    if (data.containsKey('to_town')) {
      context.handle(
        _toTownMeta,
        toTown.isAcceptableOrUnknown(data['to_town']!, _toTownMeta),
      );
    } else if (isInserting) {
      context.missing(_toTownMeta);
    }
    if (data.containsKey('city_code')) {
      context.handle(
        _cityCodeMeta,
        cityCode.isAcceptableOrUnknown(data['city_code']!, _cityCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_cityCodeMeta);
    }
    if (data.containsKey('account_code')) {
      context.handle(
        _accountCodeMeta,
        accountCode.isAcceptableOrUnknown(
          data['account_code']!,
          _accountCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountCodeMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_senderNameMeta);
    }
    if (data.containsKey('sender_phone')) {
      context.handle(
        _senderPhoneMeta,
        senderPhone.isAcceptableOrUnknown(
          data['sender_phone']!,
          _senderPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senderPhoneMeta);
    }
    if (data.containsKey('receiver_name')) {
      context.handle(
        _receiverNameMeta,
        receiverName.isAcceptableOrUnknown(
          data['receiver_name']!,
          _receiverNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receiverNameMeta);
    }
    if (data.containsKey('receiver_phone')) {
      context.handle(
        _receiverPhoneMeta,
        receiverPhone.isAcceptableOrUnknown(
          data['receiver_phone']!,
          _receiverPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receiverPhoneMeta);
    }
    if (data.containsKey('parcel_type')) {
      context.handle(
        _parcelTypeMeta,
        parcelType.isAcceptableOrUnknown(data['parcel_type']!, _parcelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_parcelTypeMeta);
    }
    if (data.containsKey('number_of_parcels')) {
      context.handle(
        _numberOfParcelsMeta,
        numberOfParcels.isAcceptableOrUnknown(
          data['number_of_parcels']!,
          _numberOfParcelsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfParcelsMeta);
    }
    if (data.containsKey('total_charges')) {
      context.handle(
        _totalChargesMeta,
        totalCharges.isAcceptableOrUnknown(
          data['total_charges']!,
          _totalChargesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalChargesMeta);
    }
    if (data.containsKey('cash_advance')) {
      context.handle(
        _cashAdvanceMeta,
        cashAdvance.isAcceptableOrUnknown(
          data['cash_advance']!,
          _cashAdvanceMeta,
        ),
      );
    }
    if (data.containsKey('parcel_image_path')) {
      context.handle(
        _parcelImagePathMeta,
        parcelImagePath.isAcceptableOrUnknown(
          data['parcel_image_path']!,
          _parcelImagePathMeta,
        ),
      );
    }
    if (data.containsKey('remark')) {
      context.handle(
        _remarkMeta,
        remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('arrived_at')) {
      context.handle(
        _arrivedAtMeta,
        arrivedAt.isAcceptableOrUnknown(data['arrived_at']!, _arrivedAtMeta),
      );
    }
    if (data.containsKey('claimed_at')) {
      context.handle(
        _claimedAtMeta,
        claimedAt.isAcceptableOrUnknown(data['claimed_at']!, _claimedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {trackingId},
  ];
  @override
  Parcel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Parcel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trackingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tracking_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      fromTown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_town'],
      )!,
      toTown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_town'],
      )!,
      cityCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_code'],
      )!,
      accountCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_code'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      )!,
      senderPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_phone'],
      )!,
      receiverName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver_name'],
      )!,
      receiverPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver_phone'],
      )!,
      parcelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parcel_type'],
      )!,
      numberOfParcels: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_parcels'],
      )!,
      totalCharges: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_charges'],
      )!,
      paymentStatus: $ParcelsTable.$converterpaymentStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}payment_status'],
        )!,
      ),
      cashAdvance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cash_advance'],
      )!,
      parcelImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parcel_image_path'],
      ),
      remark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remark'],
      ),
      status: $ParcelsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      syncStatus: $ParcelsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      arrivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}arrived_at'],
      ),
      claimedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}claimed_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ParcelsTable createAlias(String alias) {
    return $ParcelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentStatus, String, String>
  $converterpaymentStatus = const EnumNameConverter<PaymentStatus>(
    PaymentStatus.values,
  );
  static JsonTypeConverter2<ParcelStatus, String, String> $converterstatus =
      const EnumNameConverter<ParcelStatus>(ParcelStatus.values);
  static JsonTypeConverter2<SyncStatus, String, String> $convertersyncStatus =
      const EnumNameConverter<SyncStatus>(SyncStatus.values);
}

class Parcel extends DataClass implements Insertable<Parcel> {
  final int id;
  final String trackingId;
  final DateTime createdAt;
  final String fromTown;
  final String toTown;
  final String cityCode;
  final String accountCode;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String parcelType;
  final int numberOfParcels;
  final double totalCharges;
  final PaymentStatus paymentStatus;
  final double cashAdvance;
  final String? parcelImagePath;
  final String? remark;
  final ParcelStatus status;
  final SyncStatus syncStatus;
  final DateTime? syncedAt;
  final DateTime? arrivedAt;
  final DateTime? claimedAt;
  final DateTime updatedAt;
  const Parcel({
    required this.id,
    required this.trackingId,
    required this.createdAt,
    required this.fromTown,
    required this.toTown,
    required this.cityCode,
    required this.accountCode,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.parcelType,
    required this.numberOfParcels,
    required this.totalCharges,
    required this.paymentStatus,
    required this.cashAdvance,
    this.parcelImagePath,
    this.remark,
    required this.status,
    required this.syncStatus,
    this.syncedAt,
    this.arrivedAt,
    this.claimedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tracking_id'] = Variable<String>(trackingId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['from_town'] = Variable<String>(fromTown);
    map['to_town'] = Variable<String>(toTown);
    map['city_code'] = Variable<String>(cityCode);
    map['account_code'] = Variable<String>(accountCode);
    map['sender_name'] = Variable<String>(senderName);
    map['sender_phone'] = Variable<String>(senderPhone);
    map['receiver_name'] = Variable<String>(receiverName);
    map['receiver_phone'] = Variable<String>(receiverPhone);
    map['parcel_type'] = Variable<String>(parcelType);
    map['number_of_parcels'] = Variable<int>(numberOfParcels);
    map['total_charges'] = Variable<double>(totalCharges);
    {
      map['payment_status'] = Variable<String>(
        $ParcelsTable.$converterpaymentStatus.toSql(paymentStatus),
      );
    }
    map['cash_advance'] = Variable<double>(cashAdvance);
    if (!nullToAbsent || parcelImagePath != null) {
      map['parcel_image_path'] = Variable<String>(parcelImagePath);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    {
      map['status'] = Variable<String>(
        $ParcelsTable.$converterstatus.toSql(status),
      );
    }
    {
      map['sync_status'] = Variable<String>(
        $ParcelsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || arrivedAt != null) {
      map['arrived_at'] = Variable<DateTime>(arrivedAt);
    }
    if (!nullToAbsent || claimedAt != null) {
      map['claimed_at'] = Variable<DateTime>(claimedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ParcelsCompanion toCompanion(bool nullToAbsent) {
    return ParcelsCompanion(
      id: Value(id),
      trackingId: Value(trackingId),
      createdAt: Value(createdAt),
      fromTown: Value(fromTown),
      toTown: Value(toTown),
      cityCode: Value(cityCode),
      accountCode: Value(accountCode),
      senderName: Value(senderName),
      senderPhone: Value(senderPhone),
      receiverName: Value(receiverName),
      receiverPhone: Value(receiverPhone),
      parcelType: Value(parcelType),
      numberOfParcels: Value(numberOfParcels),
      totalCharges: Value(totalCharges),
      paymentStatus: Value(paymentStatus),
      cashAdvance: Value(cashAdvance),
      parcelImagePath: parcelImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(parcelImagePath),
      remark: remark == null && nullToAbsent
          ? const Value.absent()
          : Value(remark),
      status: Value(status),
      syncStatus: Value(syncStatus),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      arrivedAt: arrivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(arrivedAt),
      claimedAt: claimedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(claimedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Parcel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Parcel(
      id: serializer.fromJson<int>(json['id']),
      trackingId: serializer.fromJson<String>(json['trackingId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      fromTown: serializer.fromJson<String>(json['fromTown']),
      toTown: serializer.fromJson<String>(json['toTown']),
      cityCode: serializer.fromJson<String>(json['cityCode']),
      accountCode: serializer.fromJson<String>(json['accountCode']),
      senderName: serializer.fromJson<String>(json['senderName']),
      senderPhone: serializer.fromJson<String>(json['senderPhone']),
      receiverName: serializer.fromJson<String>(json['receiverName']),
      receiverPhone: serializer.fromJson<String>(json['receiverPhone']),
      parcelType: serializer.fromJson<String>(json['parcelType']),
      numberOfParcels: serializer.fromJson<int>(json['numberOfParcels']),
      totalCharges: serializer.fromJson<double>(json['totalCharges']),
      paymentStatus: $ParcelsTable.$converterpaymentStatus.fromJson(
        serializer.fromJson<String>(json['paymentStatus']),
      ),
      cashAdvance: serializer.fromJson<double>(json['cashAdvance']),
      parcelImagePath: serializer.fromJson<String?>(json['parcelImagePath']),
      remark: serializer.fromJson<String?>(json['remark']),
      status: $ParcelsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      syncStatus: $ParcelsTable.$convertersyncStatus.fromJson(
        serializer.fromJson<String>(json['syncStatus']),
      ),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      arrivedAt: serializer.fromJson<DateTime?>(json['arrivedAt']),
      claimedAt: serializer.fromJson<DateTime?>(json['claimedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackingId': serializer.toJson<String>(trackingId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'fromTown': serializer.toJson<String>(fromTown),
      'toTown': serializer.toJson<String>(toTown),
      'cityCode': serializer.toJson<String>(cityCode),
      'accountCode': serializer.toJson<String>(accountCode),
      'senderName': serializer.toJson<String>(senderName),
      'senderPhone': serializer.toJson<String>(senderPhone),
      'receiverName': serializer.toJson<String>(receiverName),
      'receiverPhone': serializer.toJson<String>(receiverPhone),
      'parcelType': serializer.toJson<String>(parcelType),
      'numberOfParcels': serializer.toJson<int>(numberOfParcels),
      'totalCharges': serializer.toJson<double>(totalCharges),
      'paymentStatus': serializer.toJson<String>(
        $ParcelsTable.$converterpaymentStatus.toJson(paymentStatus),
      ),
      'cashAdvance': serializer.toJson<double>(cashAdvance),
      'parcelImagePath': serializer.toJson<String?>(parcelImagePath),
      'remark': serializer.toJson<String?>(remark),
      'status': serializer.toJson<String>(
        $ParcelsTable.$converterstatus.toJson(status),
      ),
      'syncStatus': serializer.toJson<String>(
        $ParcelsTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'arrivedAt': serializer.toJson<DateTime?>(arrivedAt),
      'claimedAt': serializer.toJson<DateTime?>(claimedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Parcel copyWith({
    int? id,
    String? trackingId,
    DateTime? createdAt,
    String? fromTown,
    String? toTown,
    String? cityCode,
    String? accountCode,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? parcelType,
    int? numberOfParcels,
    double? totalCharges,
    PaymentStatus? paymentStatus,
    double? cashAdvance,
    Value<String?> parcelImagePath = const Value.absent(),
    Value<String?> remark = const Value.absent(),
    ParcelStatus? status,
    SyncStatus? syncStatus,
    Value<DateTime?> syncedAt = const Value.absent(),
    Value<DateTime?> arrivedAt = const Value.absent(),
    Value<DateTime?> claimedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => Parcel(
    id: id ?? this.id,
    trackingId: trackingId ?? this.trackingId,
    createdAt: createdAt ?? this.createdAt,
    fromTown: fromTown ?? this.fromTown,
    toTown: toTown ?? this.toTown,
    cityCode: cityCode ?? this.cityCode,
    accountCode: accountCode ?? this.accountCode,
    senderName: senderName ?? this.senderName,
    senderPhone: senderPhone ?? this.senderPhone,
    receiverName: receiverName ?? this.receiverName,
    receiverPhone: receiverPhone ?? this.receiverPhone,
    parcelType: parcelType ?? this.parcelType,
    numberOfParcels: numberOfParcels ?? this.numberOfParcels,
    totalCharges: totalCharges ?? this.totalCharges,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    cashAdvance: cashAdvance ?? this.cashAdvance,
    parcelImagePath: parcelImagePath.present
        ? parcelImagePath.value
        : this.parcelImagePath,
    remark: remark.present ? remark.value : this.remark,
    status: status ?? this.status,
    syncStatus: syncStatus ?? this.syncStatus,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    arrivedAt: arrivedAt.present ? arrivedAt.value : this.arrivedAt,
    claimedAt: claimedAt.present ? claimedAt.value : this.claimedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Parcel copyWithCompanion(ParcelsCompanion data) {
    return Parcel(
      id: data.id.present ? data.id.value : this.id,
      trackingId: data.trackingId.present
          ? data.trackingId.value
          : this.trackingId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      fromTown: data.fromTown.present ? data.fromTown.value : this.fromTown,
      toTown: data.toTown.present ? data.toTown.value : this.toTown,
      cityCode: data.cityCode.present ? data.cityCode.value : this.cityCode,
      accountCode: data.accountCode.present
          ? data.accountCode.value
          : this.accountCode,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      senderPhone: data.senderPhone.present
          ? data.senderPhone.value
          : this.senderPhone,
      receiverName: data.receiverName.present
          ? data.receiverName.value
          : this.receiverName,
      receiverPhone: data.receiverPhone.present
          ? data.receiverPhone.value
          : this.receiverPhone,
      parcelType: data.parcelType.present
          ? data.parcelType.value
          : this.parcelType,
      numberOfParcels: data.numberOfParcels.present
          ? data.numberOfParcels.value
          : this.numberOfParcels,
      totalCharges: data.totalCharges.present
          ? data.totalCharges.value
          : this.totalCharges,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      cashAdvance: data.cashAdvance.present
          ? data.cashAdvance.value
          : this.cashAdvance,
      parcelImagePath: data.parcelImagePath.present
          ? data.parcelImagePath.value
          : this.parcelImagePath,
      remark: data.remark.present ? data.remark.value : this.remark,
      status: data.status.present ? data.status.value : this.status,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      arrivedAt: data.arrivedAt.present ? data.arrivedAt.value : this.arrivedAt,
      claimedAt: data.claimedAt.present ? data.claimedAt.value : this.claimedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Parcel(')
          ..write('id: $id, ')
          ..write('trackingId: $trackingId, ')
          ..write('createdAt: $createdAt, ')
          ..write('fromTown: $fromTown, ')
          ..write('toTown: $toTown, ')
          ..write('cityCode: $cityCode, ')
          ..write('accountCode: $accountCode, ')
          ..write('senderName: $senderName, ')
          ..write('senderPhone: $senderPhone, ')
          ..write('receiverName: $receiverName, ')
          ..write('receiverPhone: $receiverPhone, ')
          ..write('parcelType: $parcelType, ')
          ..write('numberOfParcels: $numberOfParcels, ')
          ..write('totalCharges: $totalCharges, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('cashAdvance: $cashAdvance, ')
          ..write('parcelImagePath: $parcelImagePath, ')
          ..write('remark: $remark, ')
          ..write('status: $status, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('arrivedAt: $arrivedAt, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    trackingId,
    createdAt,
    fromTown,
    toTown,
    cityCode,
    accountCode,
    senderName,
    senderPhone,
    receiverName,
    receiverPhone,
    parcelType,
    numberOfParcels,
    totalCharges,
    paymentStatus,
    cashAdvance,
    parcelImagePath,
    remark,
    status,
    syncStatus,
    syncedAt,
    arrivedAt,
    claimedAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Parcel &&
          other.id == this.id &&
          other.trackingId == this.trackingId &&
          other.createdAt == this.createdAt &&
          other.fromTown == this.fromTown &&
          other.toTown == this.toTown &&
          other.cityCode == this.cityCode &&
          other.accountCode == this.accountCode &&
          other.senderName == this.senderName &&
          other.senderPhone == this.senderPhone &&
          other.receiverName == this.receiverName &&
          other.receiverPhone == this.receiverPhone &&
          other.parcelType == this.parcelType &&
          other.numberOfParcels == this.numberOfParcels &&
          other.totalCharges == this.totalCharges &&
          other.paymentStatus == this.paymentStatus &&
          other.cashAdvance == this.cashAdvance &&
          other.parcelImagePath == this.parcelImagePath &&
          other.remark == this.remark &&
          other.status == this.status &&
          other.syncStatus == this.syncStatus &&
          other.syncedAt == this.syncedAt &&
          other.arrivedAt == this.arrivedAt &&
          other.claimedAt == this.claimedAt &&
          other.updatedAt == this.updatedAt);
}

class ParcelsCompanion extends UpdateCompanion<Parcel> {
  final Value<int> id;
  final Value<String> trackingId;
  final Value<DateTime> createdAt;
  final Value<String> fromTown;
  final Value<String> toTown;
  final Value<String> cityCode;
  final Value<String> accountCode;
  final Value<String> senderName;
  final Value<String> senderPhone;
  final Value<String> receiverName;
  final Value<String> receiverPhone;
  final Value<String> parcelType;
  final Value<int> numberOfParcels;
  final Value<double> totalCharges;
  final Value<PaymentStatus> paymentStatus;
  final Value<double> cashAdvance;
  final Value<String?> parcelImagePath;
  final Value<String?> remark;
  final Value<ParcelStatus> status;
  final Value<SyncStatus> syncStatus;
  final Value<DateTime?> syncedAt;
  final Value<DateTime?> arrivedAt;
  final Value<DateTime?> claimedAt;
  final Value<DateTime> updatedAt;
  const ParcelsCompanion({
    this.id = const Value.absent(),
    this.trackingId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.fromTown = const Value.absent(),
    this.toTown = const Value.absent(),
    this.cityCode = const Value.absent(),
    this.accountCode = const Value.absent(),
    this.senderName = const Value.absent(),
    this.senderPhone = const Value.absent(),
    this.receiverName = const Value.absent(),
    this.receiverPhone = const Value.absent(),
    this.parcelType = const Value.absent(),
    this.numberOfParcels = const Value.absent(),
    this.totalCharges = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.cashAdvance = const Value.absent(),
    this.parcelImagePath = const Value.absent(),
    this.remark = const Value.absent(),
    this.status = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.arrivedAt = const Value.absent(),
    this.claimedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ParcelsCompanion.insert({
    this.id = const Value.absent(),
    required String trackingId,
    required DateTime createdAt,
    required String fromTown,
    required String toTown,
    required String cityCode,
    required String accountCode,
    required String senderName,
    required String senderPhone,
    required String receiverName,
    required String receiverPhone,
    required String parcelType,
    required int numberOfParcels,
    required double totalCharges,
    required PaymentStatus paymentStatus,
    this.cashAdvance = const Value.absent(),
    this.parcelImagePath = const Value.absent(),
    this.remark = const Value.absent(),
    this.status = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.arrivedAt = const Value.absent(),
    this.claimedAt = const Value.absent(),
    required DateTime updatedAt,
  }) : trackingId = Value(trackingId),
       createdAt = Value(createdAt),
       fromTown = Value(fromTown),
       toTown = Value(toTown),
       cityCode = Value(cityCode),
       accountCode = Value(accountCode),
       senderName = Value(senderName),
       senderPhone = Value(senderPhone),
       receiverName = Value(receiverName),
       receiverPhone = Value(receiverPhone),
       parcelType = Value(parcelType),
       numberOfParcels = Value(numberOfParcels),
       totalCharges = Value(totalCharges),
       paymentStatus = Value(paymentStatus),
       updatedAt = Value(updatedAt);
  static Insertable<Parcel> custom({
    Expression<int>? id,
    Expression<String>? trackingId,
    Expression<DateTime>? createdAt,
    Expression<String>? fromTown,
    Expression<String>? toTown,
    Expression<String>? cityCode,
    Expression<String>? accountCode,
    Expression<String>? senderName,
    Expression<String>? senderPhone,
    Expression<String>? receiverName,
    Expression<String>? receiverPhone,
    Expression<String>? parcelType,
    Expression<int>? numberOfParcels,
    Expression<double>? totalCharges,
    Expression<String>? paymentStatus,
    Expression<double>? cashAdvance,
    Expression<String>? parcelImagePath,
    Expression<String>? remark,
    Expression<String>? status,
    Expression<String>? syncStatus,
    Expression<DateTime>? syncedAt,
    Expression<DateTime>? arrivedAt,
    Expression<DateTime>? claimedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackingId != null) 'tracking_id': trackingId,
      if (createdAt != null) 'created_at': createdAt,
      if (fromTown != null) 'from_town': fromTown,
      if (toTown != null) 'to_town': toTown,
      if (cityCode != null) 'city_code': cityCode,
      if (accountCode != null) 'account_code': accountCode,
      if (senderName != null) 'sender_name': senderName,
      if (senderPhone != null) 'sender_phone': senderPhone,
      if (receiverName != null) 'receiver_name': receiverName,
      if (receiverPhone != null) 'receiver_phone': receiverPhone,
      if (parcelType != null) 'parcel_type': parcelType,
      if (numberOfParcels != null) 'number_of_parcels': numberOfParcels,
      if (totalCharges != null) 'total_charges': totalCharges,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (cashAdvance != null) 'cash_advance': cashAdvance,
      if (parcelImagePath != null) 'parcel_image_path': parcelImagePath,
      if (remark != null) 'remark': remark,
      if (status != null) 'status': status,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (arrivedAt != null) 'arrived_at': arrivedAt,
      if (claimedAt != null) 'claimed_at': claimedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ParcelsCompanion copyWith({
    Value<int>? id,
    Value<String>? trackingId,
    Value<DateTime>? createdAt,
    Value<String>? fromTown,
    Value<String>? toTown,
    Value<String>? cityCode,
    Value<String>? accountCode,
    Value<String>? senderName,
    Value<String>? senderPhone,
    Value<String>? receiverName,
    Value<String>? receiverPhone,
    Value<String>? parcelType,
    Value<int>? numberOfParcels,
    Value<double>? totalCharges,
    Value<PaymentStatus>? paymentStatus,
    Value<double>? cashAdvance,
    Value<String?>? parcelImagePath,
    Value<String?>? remark,
    Value<ParcelStatus>? status,
    Value<SyncStatus>? syncStatus,
    Value<DateTime?>? syncedAt,
    Value<DateTime?>? arrivedAt,
    Value<DateTime?>? claimedAt,
    Value<DateTime>? updatedAt,
  }) {
    return ParcelsCompanion(
      id: id ?? this.id,
      trackingId: trackingId ?? this.trackingId,
      createdAt: createdAt ?? this.createdAt,
      fromTown: fromTown ?? this.fromTown,
      toTown: toTown ?? this.toTown,
      cityCode: cityCode ?? this.cityCode,
      accountCode: accountCode ?? this.accountCode,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      parcelType: parcelType ?? this.parcelType,
      numberOfParcels: numberOfParcels ?? this.numberOfParcels,
      totalCharges: totalCharges ?? this.totalCharges,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      cashAdvance: cashAdvance ?? this.cashAdvance,
      parcelImagePath: parcelImagePath ?? this.parcelImagePath,
      remark: remark ?? this.remark,
      status: status ?? this.status,
      syncStatus: syncStatus ?? this.syncStatus,
      syncedAt: syncedAt ?? this.syncedAt,
      arrivedAt: arrivedAt ?? this.arrivedAt,
      claimedAt: claimedAt ?? this.claimedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackingId.present) {
      map['tracking_id'] = Variable<String>(trackingId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (fromTown.present) {
      map['from_town'] = Variable<String>(fromTown.value);
    }
    if (toTown.present) {
      map['to_town'] = Variable<String>(toTown.value);
    }
    if (cityCode.present) {
      map['city_code'] = Variable<String>(cityCode.value);
    }
    if (accountCode.present) {
      map['account_code'] = Variable<String>(accountCode.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (senderPhone.present) {
      map['sender_phone'] = Variable<String>(senderPhone.value);
    }
    if (receiverName.present) {
      map['receiver_name'] = Variable<String>(receiverName.value);
    }
    if (receiverPhone.present) {
      map['receiver_phone'] = Variable<String>(receiverPhone.value);
    }
    if (parcelType.present) {
      map['parcel_type'] = Variable<String>(parcelType.value);
    }
    if (numberOfParcels.present) {
      map['number_of_parcels'] = Variable<int>(numberOfParcels.value);
    }
    if (totalCharges.present) {
      map['total_charges'] = Variable<double>(totalCharges.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(
        $ParcelsTable.$converterpaymentStatus.toSql(paymentStatus.value),
      );
    }
    if (cashAdvance.present) {
      map['cash_advance'] = Variable<double>(cashAdvance.value);
    }
    if (parcelImagePath.present) {
      map['parcel_image_path'] = Variable<String>(parcelImagePath.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ParcelsTable.$converterstatus.toSql(status.value),
      );
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $ParcelsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (arrivedAt.present) {
      map['arrived_at'] = Variable<DateTime>(arrivedAt.value);
    }
    if (claimedAt.present) {
      map['claimed_at'] = Variable<DateTime>(claimedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcelsCompanion(')
          ..write('id: $id, ')
          ..write('trackingId: $trackingId, ')
          ..write('createdAt: $createdAt, ')
          ..write('fromTown: $fromTown, ')
          ..write('toTown: $toTown, ')
          ..write('cityCode: $cityCode, ')
          ..write('accountCode: $accountCode, ')
          ..write('senderName: $senderName, ')
          ..write('senderPhone: $senderPhone, ')
          ..write('receiverName: $receiverName, ')
          ..write('receiverPhone: $receiverPhone, ')
          ..write('parcelType: $parcelType, ')
          ..write('numberOfParcels: $numberOfParcels, ')
          ..write('totalCharges: $totalCharges, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('cashAdvance: $cashAdvance, ')
          ..write('parcelImagePath: $parcelImagePath, ')
          ..write('remark: $remark, ')
          ..write('status: $status, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('arrivedAt: $arrivedAt, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ParcelEventsTable extends ParcelEvents
    with TableInfo<$ParcelEventsTable, ParcelEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcelEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _parcelIdMeta = const VerificationMeta(
    'parcelId',
  );
  @override
  late final GeneratedColumn<int> parcelId = GeneratedColumn<int>(
    'parcel_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parcels (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventLabelMeta = const VerificationMeta(
    'eventLabel',
  );
  @override
  late final GeneratedColumn<String> eventLabel = GeneratedColumn<String>(
    'event_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTimeMeta = const VerificationMeta(
    'eventTime',
  );
  @override
  late final GeneratedColumn<DateTime> eventTime = GeneratedColumn<DateTime>(
    'event_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, parcelId, eventLabel, eventTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parcel_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParcelEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parcel_id')) {
      context.handle(
        _parcelIdMeta,
        parcelId.isAcceptableOrUnknown(data['parcel_id']!, _parcelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parcelIdMeta);
    }
    if (data.containsKey('event_label')) {
      context.handle(
        _eventLabelMeta,
        eventLabel.isAcceptableOrUnknown(data['event_label']!, _eventLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_eventLabelMeta);
    }
    if (data.containsKey('event_time')) {
      context.handle(
        _eventTimeMeta,
        eventTime.isAcceptableOrUnknown(data['event_time']!, _eventTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParcelEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParcelEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      parcelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parcel_id'],
      )!,
      eventLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_label'],
      )!,
      eventTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_time'],
      )!,
    );
  }

  @override
  $ParcelEventsTable createAlias(String alias) {
    return $ParcelEventsTable(attachedDatabase, alias);
  }
}

class ParcelEvent extends DataClass implements Insertable<ParcelEvent> {
  final int id;
  final int parcelId;
  final String eventLabel;
  final DateTime eventTime;
  const ParcelEvent({
    required this.id,
    required this.parcelId,
    required this.eventLabel,
    required this.eventTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['parcel_id'] = Variable<int>(parcelId);
    map['event_label'] = Variable<String>(eventLabel);
    map['event_time'] = Variable<DateTime>(eventTime);
    return map;
  }

  ParcelEventsCompanion toCompanion(bool nullToAbsent) {
    return ParcelEventsCompanion(
      id: Value(id),
      parcelId: Value(parcelId),
      eventLabel: Value(eventLabel),
      eventTime: Value(eventTime),
    );
  }

  factory ParcelEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParcelEvent(
      id: serializer.fromJson<int>(json['id']),
      parcelId: serializer.fromJson<int>(json['parcelId']),
      eventLabel: serializer.fromJson<String>(json['eventLabel']),
      eventTime: serializer.fromJson<DateTime>(json['eventTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parcelId': serializer.toJson<int>(parcelId),
      'eventLabel': serializer.toJson<String>(eventLabel),
      'eventTime': serializer.toJson<DateTime>(eventTime),
    };
  }

  ParcelEvent copyWith({
    int? id,
    int? parcelId,
    String? eventLabel,
    DateTime? eventTime,
  }) => ParcelEvent(
    id: id ?? this.id,
    parcelId: parcelId ?? this.parcelId,
    eventLabel: eventLabel ?? this.eventLabel,
    eventTime: eventTime ?? this.eventTime,
  );
  ParcelEvent copyWithCompanion(ParcelEventsCompanion data) {
    return ParcelEvent(
      id: data.id.present ? data.id.value : this.id,
      parcelId: data.parcelId.present ? data.parcelId.value : this.parcelId,
      eventLabel: data.eventLabel.present
          ? data.eventLabel.value
          : this.eventLabel,
      eventTime: data.eventTime.present ? data.eventTime.value : this.eventTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParcelEvent(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('eventLabel: $eventLabel, ')
          ..write('eventTime: $eventTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parcelId, eventLabel, eventTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParcelEvent &&
          other.id == this.id &&
          other.parcelId == this.parcelId &&
          other.eventLabel == this.eventLabel &&
          other.eventTime == this.eventTime);
}

class ParcelEventsCompanion extends UpdateCompanion<ParcelEvent> {
  final Value<int> id;
  final Value<int> parcelId;
  final Value<String> eventLabel;
  final Value<DateTime> eventTime;
  const ParcelEventsCompanion({
    this.id = const Value.absent(),
    this.parcelId = const Value.absent(),
    this.eventLabel = const Value.absent(),
    this.eventTime = const Value.absent(),
  });
  ParcelEventsCompanion.insert({
    this.id = const Value.absent(),
    required int parcelId,
    required String eventLabel,
    required DateTime eventTime,
  }) : parcelId = Value(parcelId),
       eventLabel = Value(eventLabel),
       eventTime = Value(eventTime);
  static Insertable<ParcelEvent> custom({
    Expression<int>? id,
    Expression<int>? parcelId,
    Expression<String>? eventLabel,
    Expression<DateTime>? eventTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parcelId != null) 'parcel_id': parcelId,
      if (eventLabel != null) 'event_label': eventLabel,
      if (eventTime != null) 'event_time': eventTime,
    });
  }

  ParcelEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? parcelId,
    Value<String>? eventLabel,
    Value<DateTime>? eventTime,
  }) {
    return ParcelEventsCompanion(
      id: id ?? this.id,
      parcelId: parcelId ?? this.parcelId,
      eventLabel: eventLabel ?? this.eventLabel,
      eventTime: eventTime ?? this.eventTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parcelId.present) {
      map['parcel_id'] = Variable<int>(parcelId.value);
    }
    if (eventLabel.present) {
      map['event_label'] = Variable<String>(eventLabel.value);
    }
    if (eventTime.present) {
      map['event_time'] = Variable<DateTime>(eventTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcelEventsCompanion(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('eventLabel: $eventLabel, ')
          ..write('eventTime: $eventTime')
          ..write(')'))
        .toString();
  }
}

class $TownsTable extends Towns with TableInfo<$TownsTable, Town> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TownsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _townNameMeta = const VerificationMeta(
    'townName',
  );
  @override
  late final GeneratedColumn<String> townName = GeneratedColumn<String>(
    'town_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TownType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TownType>($TownsTable.$convertertype);
  static const VerificationMeta _cityCodeMeta = const VerificationMeta(
    'cityCode',
  );
  @override
  late final GeneratedColumn<String> cityCode = GeneratedColumn<String>(
    'city_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    townName,
    type,
    cityCode,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'towns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Town> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('town_name')) {
      context.handle(
        _townNameMeta,
        townName.isAcceptableOrUnknown(data['town_name']!, _townNameMeta),
      );
    } else if (isInserting) {
      context.missing(_townNameMeta);
    }
    if (data.containsKey('city_code')) {
      context.handle(
        _cityCodeMeta,
        cityCode.isAcceptableOrUnknown(data['city_code']!, _cityCodeMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {type, townName},
  ];
  @override
  Town map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Town(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      townName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}town_name'],
      )!,
      type: $TownsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      cityCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_code'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $TownsTable createAlias(String alias) {
    return $TownsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TownType, String, String> $convertertype =
      const EnumNameConverter<TownType>(TownType.values);
}

class Town extends DataClass implements Insertable<Town> {
  final int id;
  final String townName;
  final TownType type;
  final String? cityCode;
  final int sortOrder;
  const Town({
    required this.id,
    required this.townName,
    required this.type,
    this.cityCode,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['town_name'] = Variable<String>(townName);
    {
      map['type'] = Variable<String>($TownsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || cityCode != null) {
      map['city_code'] = Variable<String>(cityCode);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  TownsCompanion toCompanion(bool nullToAbsent) {
    return TownsCompanion(
      id: Value(id),
      townName: Value(townName),
      type: Value(type),
      cityCode: cityCode == null && nullToAbsent
          ? const Value.absent()
          : Value(cityCode),
      sortOrder: Value(sortOrder),
    );
  }

  factory Town.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Town(
      id: serializer.fromJson<int>(json['id']),
      townName: serializer.fromJson<String>(json['townName']),
      type: $TownsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      cityCode: serializer.fromJson<String?>(json['cityCode']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'townName': serializer.toJson<String>(townName),
      'type': serializer.toJson<String>(
        $TownsTable.$convertertype.toJson(type),
      ),
      'cityCode': serializer.toJson<String?>(cityCode),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Town copyWith({
    int? id,
    String? townName,
    TownType? type,
    Value<String?> cityCode = const Value.absent(),
    int? sortOrder,
  }) => Town(
    id: id ?? this.id,
    townName: townName ?? this.townName,
    type: type ?? this.type,
    cityCode: cityCode.present ? cityCode.value : this.cityCode,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Town copyWithCompanion(TownsCompanion data) {
    return Town(
      id: data.id.present ? data.id.value : this.id,
      townName: data.townName.present ? data.townName.value : this.townName,
      type: data.type.present ? data.type.value : this.type,
      cityCode: data.cityCode.present ? data.cityCode.value : this.cityCode,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Town(')
          ..write('id: $id, ')
          ..write('townName: $townName, ')
          ..write('type: $type, ')
          ..write('cityCode: $cityCode, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, townName, type, cityCode, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Town &&
          other.id == this.id &&
          other.townName == this.townName &&
          other.type == this.type &&
          other.cityCode == this.cityCode &&
          other.sortOrder == this.sortOrder);
}

class TownsCompanion extends UpdateCompanion<Town> {
  final Value<int> id;
  final Value<String> townName;
  final Value<TownType> type;
  final Value<String?> cityCode;
  final Value<int> sortOrder;
  const TownsCompanion({
    this.id = const Value.absent(),
    this.townName = const Value.absent(),
    this.type = const Value.absent(),
    this.cityCode = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  TownsCompanion.insert({
    this.id = const Value.absent(),
    required String townName,
    required TownType type,
    this.cityCode = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : townName = Value(townName),
       type = Value(type);
  static Insertable<Town> custom({
    Expression<int>? id,
    Expression<String>? townName,
    Expression<String>? type,
    Expression<String>? cityCode,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (townName != null) 'town_name': townName,
      if (type != null) 'type': type,
      if (cityCode != null) 'city_code': cityCode,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  TownsCompanion copyWith({
    Value<int>? id,
    Value<String>? townName,
    Value<TownType>? type,
    Value<String?>? cityCode,
    Value<int>? sortOrder,
  }) {
    return TownsCompanion(
      id: id ?? this.id,
      townName: townName ?? this.townName,
      type: type ?? this.type,
      cityCode: cityCode ?? this.cityCode,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (townName.present) {
      map['town_name'] = Variable<String>(townName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TownsTable.$convertertype.toSql(type.value),
      );
    }
    if (cityCode.present) {
      map['city_code'] = Variable<String>(cityCode.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TownsCompanion(')
          ..write('id: $id, ')
          ..write('townName: $townName, ')
          ..write('type: $type, ')
          ..write('cityCode: $cityCode, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ParcelsTable parcels = $ParcelsTable(this);
  late final $ParcelEventsTable parcelEvents = $ParcelEventsTable(this);
  late final $TownsTable towns = $TownsTable(this);
  late final ParcelsDao parcelsDao = ParcelsDao(this as AppDatabase);
  late final ParcelEventsDao parcelEventsDao = ParcelEventsDao(
    this as AppDatabase,
  );
  late final TownsDao townsDao = TownsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    parcels,
    parcelEvents,
    towns,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parcels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parcel_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ParcelsTableCreateCompanionBuilder =
    ParcelsCompanion Function({
      Value<int> id,
      required String trackingId,
      required DateTime createdAt,
      required String fromTown,
      required String toTown,
      required String cityCode,
      required String accountCode,
      required String senderName,
      required String senderPhone,
      required String receiverName,
      required String receiverPhone,
      required String parcelType,
      required int numberOfParcels,
      required double totalCharges,
      required PaymentStatus paymentStatus,
      Value<double> cashAdvance,
      Value<String?> parcelImagePath,
      Value<String?> remark,
      Value<ParcelStatus> status,
      Value<SyncStatus> syncStatus,
      Value<DateTime?> syncedAt,
      Value<DateTime?> arrivedAt,
      Value<DateTime?> claimedAt,
      required DateTime updatedAt,
    });
typedef $$ParcelsTableUpdateCompanionBuilder =
    ParcelsCompanion Function({
      Value<int> id,
      Value<String> trackingId,
      Value<DateTime> createdAt,
      Value<String> fromTown,
      Value<String> toTown,
      Value<String> cityCode,
      Value<String> accountCode,
      Value<String> senderName,
      Value<String> senderPhone,
      Value<String> receiverName,
      Value<String> receiverPhone,
      Value<String> parcelType,
      Value<int> numberOfParcels,
      Value<double> totalCharges,
      Value<PaymentStatus> paymentStatus,
      Value<double> cashAdvance,
      Value<String?> parcelImagePath,
      Value<String?> remark,
      Value<ParcelStatus> status,
      Value<SyncStatus> syncStatus,
      Value<DateTime?> syncedAt,
      Value<DateTime?> arrivedAt,
      Value<DateTime?> claimedAt,
      Value<DateTime> updatedAt,
    });

final class $$ParcelsTableReferences
    extends BaseReferences<_$AppDatabase, $ParcelsTable, Parcel> {
  $$ParcelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ParcelEventsTable, List<ParcelEvent>>
  _parcelEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parcelEvents,
    aliasName: $_aliasNameGenerator(db.parcels.id, db.parcelEvents.parcelId),
  );

  $$ParcelEventsTableProcessedTableManager get parcelEventsRefs {
    final manager = $$ParcelEventsTableTableManager(
      $_db,
      $_db.parcelEvents,
    ).filter((f) => f.parcelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_parcelEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ParcelsTableFilterComposer
    extends Composer<_$AppDatabase, $ParcelsTable> {
  $$ParcelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackingId => $composableBuilder(
    column: $table.trackingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromTown => $composableBuilder(
    column: $table.fromTown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toTown => $composableBuilder(
    column: $table.toTown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cityCode => $composableBuilder(
    column: $table.cityCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountCode => $composableBuilder(
    column: $table.accountCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderPhone => $composableBuilder(
    column: $table.senderPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiverPhone => $composableBuilder(
    column: $table.receiverPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parcelType => $composableBuilder(
    column: $table.parcelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfParcels => $composableBuilder(
    column: $table.numberOfParcels,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCharges => $composableBuilder(
    column: $table.totalCharges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentStatus, PaymentStatus, String>
  get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get cashAdvance => $composableBuilder(
    column: $table.cashAdvance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parcelImagePath => $composableBuilder(
    column: $table.parcelImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ParcelStatus, ParcelStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get arrivedAt => $composableBuilder(
    column: $table.arrivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get claimedAt => $composableBuilder(
    column: $table.claimedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> parcelEventsRefs(
    Expression<bool> Function($$ParcelEventsTableFilterComposer f) f,
  ) {
    final $$ParcelEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelEvents,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelEventsTableFilterComposer(
            $db: $db,
            $table: $db.parcelEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParcelsTableOrderingComposer
    extends Composer<_$AppDatabase, $ParcelsTable> {
  $$ParcelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackingId => $composableBuilder(
    column: $table.trackingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromTown => $composableBuilder(
    column: $table.fromTown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toTown => $composableBuilder(
    column: $table.toTown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityCode => $composableBuilder(
    column: $table.cityCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountCode => $composableBuilder(
    column: $table.accountCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderPhone => $composableBuilder(
    column: $table.senderPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiverPhone => $composableBuilder(
    column: $table.receiverPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parcelType => $composableBuilder(
    column: $table.parcelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfParcels => $composableBuilder(
    column: $table.numberOfParcels,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCharges => $composableBuilder(
    column: $table.totalCharges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cashAdvance => $composableBuilder(
    column: $table.cashAdvance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parcelImagePath => $composableBuilder(
    column: $table.parcelImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get arrivedAt => $composableBuilder(
    column: $table.arrivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get claimedAt => $composableBuilder(
    column: $table.claimedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ParcelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParcelsTable> {
  $$ParcelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trackingId => $composableBuilder(
    column: $table.trackingId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get fromTown =>
      $composableBuilder(column: $table.fromTown, builder: (column) => column);

  GeneratedColumn<String> get toTown =>
      $composableBuilder(column: $table.toTown, builder: (column) => column);

  GeneratedColumn<String> get cityCode =>
      $composableBuilder(column: $table.cityCode, builder: (column) => column);

  GeneratedColumn<String> get accountCode => $composableBuilder(
    column: $table.accountCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderPhone => $composableBuilder(
    column: $table.senderPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiverPhone => $composableBuilder(
    column: $table.receiverPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parcelType => $composableBuilder(
    column: $table.parcelType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfParcels => $composableBuilder(
    column: $table.numberOfParcels,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCharges => $composableBuilder(
    column: $table.totalCharges,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PaymentStatus, String> get paymentStatus =>
      $composableBuilder(
        column: $table.paymentStatus,
        builder: (column) => column,
      );

  GeneratedColumn<double> get cashAdvance => $composableBuilder(
    column: $table.cashAdvance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parcelImagePath => $composableBuilder(
    column: $table.parcelImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ParcelStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get arrivedAt =>
      $composableBuilder(column: $table.arrivedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get claimedAt =>
      $composableBuilder(column: $table.claimedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> parcelEventsRefs<T extends Object>(
    Expression<T> Function($$ParcelEventsTableAnnotationComposer a) f,
  ) {
    final $$ParcelEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelEvents,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParcelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParcelsTable,
          Parcel,
          $$ParcelsTableFilterComposer,
          $$ParcelsTableOrderingComposer,
          $$ParcelsTableAnnotationComposer,
          $$ParcelsTableCreateCompanionBuilder,
          $$ParcelsTableUpdateCompanionBuilder,
          (Parcel, $$ParcelsTableReferences),
          Parcel,
          PrefetchHooks Function({bool parcelEventsRefs})
        > {
  $$ParcelsTableTableManager(_$AppDatabase db, $ParcelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParcelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParcelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParcelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> trackingId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> fromTown = const Value.absent(),
                Value<String> toTown = const Value.absent(),
                Value<String> cityCode = const Value.absent(),
                Value<String> accountCode = const Value.absent(),
                Value<String> senderName = const Value.absent(),
                Value<String> senderPhone = const Value.absent(),
                Value<String> receiverName = const Value.absent(),
                Value<String> receiverPhone = const Value.absent(),
                Value<String> parcelType = const Value.absent(),
                Value<int> numberOfParcels = const Value.absent(),
                Value<double> totalCharges = const Value.absent(),
                Value<PaymentStatus> paymentStatus = const Value.absent(),
                Value<double> cashAdvance = const Value.absent(),
                Value<String?> parcelImagePath = const Value.absent(),
                Value<String?> remark = const Value.absent(),
                Value<ParcelStatus> status = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<DateTime?> arrivedAt = const Value.absent(),
                Value<DateTime?> claimedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ParcelsCompanion(
                id: id,
                trackingId: trackingId,
                createdAt: createdAt,
                fromTown: fromTown,
                toTown: toTown,
                cityCode: cityCode,
                accountCode: accountCode,
                senderName: senderName,
                senderPhone: senderPhone,
                receiverName: receiverName,
                receiverPhone: receiverPhone,
                parcelType: parcelType,
                numberOfParcels: numberOfParcels,
                totalCharges: totalCharges,
                paymentStatus: paymentStatus,
                cashAdvance: cashAdvance,
                parcelImagePath: parcelImagePath,
                remark: remark,
                status: status,
                syncStatus: syncStatus,
                syncedAt: syncedAt,
                arrivedAt: arrivedAt,
                claimedAt: claimedAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String trackingId,
                required DateTime createdAt,
                required String fromTown,
                required String toTown,
                required String cityCode,
                required String accountCode,
                required String senderName,
                required String senderPhone,
                required String receiverName,
                required String receiverPhone,
                required String parcelType,
                required int numberOfParcels,
                required double totalCharges,
                required PaymentStatus paymentStatus,
                Value<double> cashAdvance = const Value.absent(),
                Value<String?> parcelImagePath = const Value.absent(),
                Value<String?> remark = const Value.absent(),
                Value<ParcelStatus> status = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<DateTime?> arrivedAt = const Value.absent(),
                Value<DateTime?> claimedAt = const Value.absent(),
                required DateTime updatedAt,
              }) => ParcelsCompanion.insert(
                id: id,
                trackingId: trackingId,
                createdAt: createdAt,
                fromTown: fromTown,
                toTown: toTown,
                cityCode: cityCode,
                accountCode: accountCode,
                senderName: senderName,
                senderPhone: senderPhone,
                receiverName: receiverName,
                receiverPhone: receiverPhone,
                parcelType: parcelType,
                numberOfParcels: numberOfParcels,
                totalCharges: totalCharges,
                paymentStatus: paymentStatus,
                cashAdvance: cashAdvance,
                parcelImagePath: parcelImagePath,
                remark: remark,
                status: status,
                syncStatus: syncStatus,
                syncedAt: syncedAt,
                arrivedAt: arrivedAt,
                claimedAt: claimedAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParcelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parcelEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (parcelEventsRefs) db.parcelEvents],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (parcelEventsRefs)
                    await $_getPrefetchedData<
                      Parcel,
                      $ParcelsTable,
                      ParcelEvent
                    >(
                      currentTable: table,
                      referencedTable: $$ParcelsTableReferences
                          ._parcelEventsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ParcelsTableReferences(
                        db,
                        table,
                        p0,
                      ).parcelEventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.parcelId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ParcelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParcelsTable,
      Parcel,
      $$ParcelsTableFilterComposer,
      $$ParcelsTableOrderingComposer,
      $$ParcelsTableAnnotationComposer,
      $$ParcelsTableCreateCompanionBuilder,
      $$ParcelsTableUpdateCompanionBuilder,
      (Parcel, $$ParcelsTableReferences),
      Parcel,
      PrefetchHooks Function({bool parcelEventsRefs})
    >;
typedef $$ParcelEventsTableCreateCompanionBuilder =
    ParcelEventsCompanion Function({
      Value<int> id,
      required int parcelId,
      required String eventLabel,
      required DateTime eventTime,
    });
typedef $$ParcelEventsTableUpdateCompanionBuilder =
    ParcelEventsCompanion Function({
      Value<int> id,
      Value<int> parcelId,
      Value<String> eventLabel,
      Value<DateTime> eventTime,
    });

final class $$ParcelEventsTableReferences
    extends BaseReferences<_$AppDatabase, $ParcelEventsTable, ParcelEvent> {
  $$ParcelEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ParcelsTable _parcelIdTable(_$AppDatabase db) =>
      db.parcels.createAlias(
        $_aliasNameGenerator(db.parcelEvents.parcelId, db.parcels.id),
      );

  $$ParcelsTableProcessedTableManager get parcelId {
    final $_column = $_itemColumn<int>('parcel_id')!;

    final manager = $$ParcelsTableTableManager(
      $_db,
      $_db.parcels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parcelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParcelEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ParcelEventsTable> {
  $$ParcelEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventLabel => $composableBuilder(
    column: $table.eventLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eventTime => $composableBuilder(
    column: $table.eventTime,
    builder: (column) => ColumnFilters(column),
  );

  $$ParcelsTableFilterComposer get parcelId {
    final $$ParcelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableFilterComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ParcelEventsTable> {
  $$ParcelEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventLabel => $composableBuilder(
    column: $table.eventLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventTime => $composableBuilder(
    column: $table.eventTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParcelsTableOrderingComposer get parcelId {
    final $$ParcelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableOrderingComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParcelEventsTable> {
  $$ParcelEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventLabel => $composableBuilder(
    column: $table.eventLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get eventTime =>
      $composableBuilder(column: $table.eventTime, builder: (column) => column);

  $$ParcelsTableAnnotationComposer get parcelId {
    final $$ParcelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableAnnotationComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParcelEventsTable,
          ParcelEvent,
          $$ParcelEventsTableFilterComposer,
          $$ParcelEventsTableOrderingComposer,
          $$ParcelEventsTableAnnotationComposer,
          $$ParcelEventsTableCreateCompanionBuilder,
          $$ParcelEventsTableUpdateCompanionBuilder,
          (ParcelEvent, $$ParcelEventsTableReferences),
          ParcelEvent,
          PrefetchHooks Function({bool parcelId})
        > {
  $$ParcelEventsTableTableManager(_$AppDatabase db, $ParcelEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParcelEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParcelEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParcelEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> parcelId = const Value.absent(),
                Value<String> eventLabel = const Value.absent(),
                Value<DateTime> eventTime = const Value.absent(),
              }) => ParcelEventsCompanion(
                id: id,
                parcelId: parcelId,
                eventLabel: eventLabel,
                eventTime: eventTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int parcelId,
                required String eventLabel,
                required DateTime eventTime,
              }) => ParcelEventsCompanion.insert(
                id: id,
                parcelId: parcelId,
                eventLabel: eventLabel,
                eventTime: eventTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParcelEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parcelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parcelId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parcelId,
                                referencedTable: $$ParcelEventsTableReferences
                                    ._parcelIdTable(db),
                                referencedColumn: $$ParcelEventsTableReferences
                                    ._parcelIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParcelEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParcelEventsTable,
      ParcelEvent,
      $$ParcelEventsTableFilterComposer,
      $$ParcelEventsTableOrderingComposer,
      $$ParcelEventsTableAnnotationComposer,
      $$ParcelEventsTableCreateCompanionBuilder,
      $$ParcelEventsTableUpdateCompanionBuilder,
      (ParcelEvent, $$ParcelEventsTableReferences),
      ParcelEvent,
      PrefetchHooks Function({bool parcelId})
    >;
typedef $$TownsTableCreateCompanionBuilder =
    TownsCompanion Function({
      Value<int> id,
      required String townName,
      required TownType type,
      Value<String?> cityCode,
      Value<int> sortOrder,
    });
typedef $$TownsTableUpdateCompanionBuilder =
    TownsCompanion Function({
      Value<int> id,
      Value<String> townName,
      Value<TownType> type,
      Value<String?> cityCode,
      Value<int> sortOrder,
    });

class $$TownsTableFilterComposer extends Composer<_$AppDatabase, $TownsTable> {
  $$TownsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get townName => $composableBuilder(
    column: $table.townName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TownType, TownType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get cityCode => $composableBuilder(
    column: $table.cityCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TownsTableOrderingComposer
    extends Composer<_$AppDatabase, $TownsTable> {
  $$TownsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get townName => $composableBuilder(
    column: $table.townName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityCode => $composableBuilder(
    column: $table.cityCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TownsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TownsTable> {
  $$TownsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get townName =>
      $composableBuilder(column: $table.townName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TownType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get cityCode =>
      $composableBuilder(column: $table.cityCode, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$TownsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TownsTable,
          Town,
          $$TownsTableFilterComposer,
          $$TownsTableOrderingComposer,
          $$TownsTableAnnotationComposer,
          $$TownsTableCreateCompanionBuilder,
          $$TownsTableUpdateCompanionBuilder,
          (Town, BaseReferences<_$AppDatabase, $TownsTable, Town>),
          Town,
          PrefetchHooks Function()
        > {
  $$TownsTableTableManager(_$AppDatabase db, $TownsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TownsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TownsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TownsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> townName = const Value.absent(),
                Value<TownType> type = const Value.absent(),
                Value<String?> cityCode = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => TownsCompanion(
                id: id,
                townName: townName,
                type: type,
                cityCode: cityCode,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String townName,
                required TownType type,
                Value<String?> cityCode = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => TownsCompanion.insert(
                id: id,
                townName: townName,
                type: type,
                cityCode: cityCode,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TownsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TownsTable,
      Town,
      $$TownsTableFilterComposer,
      $$TownsTableOrderingComposer,
      $$TownsTableAnnotationComposer,
      $$TownsTableCreateCompanionBuilder,
      $$TownsTableUpdateCompanionBuilder,
      (Town, BaseReferences<_$AppDatabase, $TownsTable, Town>),
      Town,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db, _db.parcels);
  $$ParcelEventsTableTableManager get parcelEvents =>
      $$ParcelEventsTableTableManager(_db, _db.parcelEvents);
  $$TownsTableTableManager get towns =>
      $$TownsTableTableManager(_db, _db.towns);
}

mixin _$ParcelsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  ParcelsDaoManager get managers => ParcelsDaoManager(this);
}

class ParcelsDaoManager {
  final _$ParcelsDaoMixin _db;
  ParcelsDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
}

mixin _$ParcelEventsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $ParcelEventsTable get parcelEvents => attachedDatabase.parcelEvents;
  ParcelEventsDaoManager get managers => ParcelEventsDaoManager(this);
}

class ParcelEventsDaoManager {
  final _$ParcelEventsDaoMixin _db;
  ParcelEventsDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$ParcelEventsTableTableManager get parcelEvents =>
      $$ParcelEventsTableTableManager(_db.attachedDatabase, _db.parcelEvents);
}

mixin _$TownsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TownsTable get towns => attachedDatabase.towns;
  TownsDaoManager get managers => TownsDaoManager(this);
}

class TownsDaoManager {
  final _$TownsDaoMixin _db;
  TownsDaoManager(this._db);
  $$TownsTableTableManager get towns =>
      $$TownsTableTableManager(_db.attachedDatabase, _db.towns);
}
