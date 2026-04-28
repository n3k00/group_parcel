enum SyncStatus {
  pending('pending'),
  synced('synced'),
  failed('failed');

  const SyncStatus(this.value);

  final String value;

  static SyncStatus fromValue(String value) {
    return SyncStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => SyncStatus.pending,
    );
  }
}
