class AppConfig {
  // Singleton object
  static final AppConfig _singleton = new AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();
  String deviceId;

  // Set app configuration with single function
  void setAppConfig({
    String deviceId,
  }) {
    this.deviceId = deviceId ?? this.deviceId;
  }
}
