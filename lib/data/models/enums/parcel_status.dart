enum ParcelStatus {
  received('received'),
  dispatched('dispatched'),
  arrived('arrived'),
  claimed('claimed');

  const ParcelStatus(this.value);

  final String value;

  static ParcelStatus fromValue(String value) {
    return ParcelStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => ParcelStatus.received,
    );
  }
}
