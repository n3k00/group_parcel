class ParcelModel {
  const ParcelModel({
    this.id,
    required this.trackingNumber,
    required this.receiverName,
    this.receiverPhone,
    required this.status,
    this.routeCode,
    this.note,
    required this.createdAt,
  });

  final int? id;
  final String trackingNumber;
  final String receiverName;
  final String? receiverPhone;
  final String status;
  final String? routeCode;
  final String? note;
  final DateTime createdAt;
}
