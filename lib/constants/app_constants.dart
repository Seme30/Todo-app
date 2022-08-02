class AppConstants {
  static const String APP_NAME = "SEME TODOAPP";
  static const int APP_VERSION = 1;

  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }
}
