class AppController {
  static final AppController _instance = AppController._internal();

  factory AppController() => _instance;

  AppController._internal();

  static AppController get instance => _instance;
}
