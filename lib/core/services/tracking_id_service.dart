class TrackingIdService {
  const TrackingIdService();

  String generate({
    required String cityCode,
    required String accountCode,
    required DateTime now,
    required int runningNumber,
  }) {
    final shortYear = (now.year % 100).toString().padLeft(2, '0');
    final dateSegment = '$shortYear${_two(now.month)}${_two(now.day)}';
    final serial = runningNumber.toString().padLeft(4, '0');

    return '${cityCode.toUpperCase()}-${accountCode.toUpperCase()}-$dateSegment-$serial';
  }

  String _two(int value) => value.toString().padLeft(2, '0');
}
