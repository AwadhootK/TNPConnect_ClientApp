part of 'auth_bloc.dart';

abstract class AuthEvents {}

class AuthInitialEvent extends AuthEvents {}

class CheckLoginEvent extends AuthEvents {}

class UserLoginEvent extends AuthEvents {
  String username;
  String password;

  UserLoginEvent(this.username, this.password);
}

class UserSignUpEvent extends AuthEvents {
  String username;
  String password;

  UserSignUpEvent(this.username, this.password);
}

class RefreshTokenExpireEvent extends AuthEvents {}

class LogOutEvent extends AuthEvents {}

class EnrollFormEvent extends AuthEvents {
  Map<String, dynamic> formDetails;

  EnrollFormEvent(this.formDetails);
}
