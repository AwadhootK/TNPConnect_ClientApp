part of 'auth_bloc.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthErrorState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginFailureState extends AuthStates {}

class SignUpSuccessState extends AuthStates {}

class SignUpFailureState extends AuthStates {}

class RefreshTokenExpireSuccessState extends AuthStates {}

class RefreshTokenExpireErrorState extends AuthStates {}

class LogOutState extends AuthStates {}

class DeviceIDUpdated extends AuthStates {}

class AutoLoginFailureState extends AuthStates {}
