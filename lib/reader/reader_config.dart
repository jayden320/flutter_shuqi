class ReaderConfig {

  static ReaderConfig _instance;
  static ReaderConfig get instance {
    if (_instance == null) {
      _instance = ReaderConfig();
    }
    return _instance;
  }


  double fontSize = 20.0;
}