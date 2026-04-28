enum TownType {
  source('source'),
  destination('destination');

  const TownType(this.value);

  final String value;

  static TownType fromValue(String value) {
    return TownType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => TownType.destination,
    );
  }
}

class TownModel {
  const TownModel({
    this.id,
    required this.townName,
    required this.type,
    this.cityCode,
    this.sortOrder = 0,
  });

  final int? id;
  final String townName;
  final TownType type;
  final String? cityCode;
  final int sortOrder;

  bool get isSource => type == TownType.source;

  bool get isDestination => type == TownType.destination;

  TownModel copyWith({
    int? id,
    String? townName,
    TownType? type,
    String? cityCode,
    bool clearCityCode = false,
    int? sortOrder,
  }) {
    return TownModel(
      id: id ?? this.id,
      townName: townName ?? this.townName,
      type: type ?? this.type,
      cityCode: clearCityCode ? null : cityCode ?? this.cityCode,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'townName': townName,
      'type': type.value,
      'cityCode': cityCode,
      'sortOrder': sortOrder,
    };
  }

  factory TownModel.fromMap(Map<String, dynamic> map) {
    return TownModel(
      id: map['id'] as int?,
      townName: map['townName'] as String,
      type: TownType.fromValue(map['type'] as String),
      cityCode: map['cityCode'] as String?,
      sortOrder: (map['sortOrder'] as num?)?.toInt() ?? 0,
    );
  }
}
