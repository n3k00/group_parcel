enum AppEnvironment {
  dev('dev'),
  prod('prod');

  const AppEnvironment(this.value);

  final String value;

  static AppEnvironment fromValue(String value) {
    return AppEnvironment.values.firstWhere(
      (environment) => environment.value == value,
      orElse: () => AppEnvironment.prod,
    );
  }
}
