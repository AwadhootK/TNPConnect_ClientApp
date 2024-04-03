class User {
  String enrollmentNumber;

  User._privateConstructor(this.enrollmentNumber);

  static final User _instance = User._privateConstructor("");

  static User get instance => _instance;

  void updateInfo(String username, String enrollmentNumber) {
    this.enrollmentNumber = enrollmentNumber;
  }
}
