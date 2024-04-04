import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tnpconnect/constants/endpoints.dart';
import 'package:tnpconnect/constants/user.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(AuthInitialState()) {
    on<CheckLoginEvent>(checkLoginEventHandler);
    on<UserLoginEvent>(userLoginEventHandler);
    on<UserSignUpEvent>(userSignUpEventHandler);
    on<RefreshTokenExpireEvent>(refreshTokenExpireEventHandler);
    on<LogOutEvent>(logOutEventHandler);
    on<EnrollFormEvent>(enrollFormEventHandler);
  }

  FutureOr<void> checkLoginEventHandler(CheckLoginEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoadingState());

      // authenticate
      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'accessToken');

      if (accessToken != null) {
        //! add here...
        const storage = FlutterSecureStorage();
        final enrollmentNo = await storage.read(key: 'enrollmentNo');

        User.instance.enrollmentNumber = enrollmentNo ?? "";
        emit(LoginSuccessState());
        return;
      }

      emit(LoginFailureState());
    } catch (e) {
      log(e.toString());
      emit(LoginFailureState());
    }
  }

  FutureOr<void> userLoginEventHandler(UserLoginEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoadingState());
      final url = Uri.parse(Endpoints.login);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'erno': event.username, 'pwd': event.password});

      log(body);

      final response = await http.post(url, headers: headers, body: body);

      inspect(response);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        log("data = $data");
        const storage = FlutterSecureStorage();
        await storage.write(key: 'accessToken', value: data['accessToken']);
        await storage.write(key: 'refreshToken', value: data['refreshToken']);
        await storage.write(key: 'enrollmentNo', value: event.username);

        User.instance.enrollmentNumber = event.username;

        emit(LoginSuccessState());
      } else {
        emit(LoginFailureState());
      }
    } catch (e) {
      log(e.toString());
      emit(LoginFailureState());
    }
  }

  FutureOr<void> userSignUpEventHandler(UserSignUpEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoadingState());
      final url = Uri.parse(Endpoints.signup);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'username': event.username, 'password': event.password});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        log("data = ${data.toString()}");
        const storage = FlutterSecureStorage();
        await storage.write(key: 'accessToken', value: data['accessToken']);
        await storage.write(key: 'refreshToken', value: data['refreshToken']);

        User.instance.enrollmentNumber = event.username;

        emit(SignUpSuccessState());
      } else {
        emit(SignUpFailureState());
      }
    } catch (e) {
      log(e.toString());
      emit(SignUpFailureState());
    }
  }

  FutureOr<void> refreshTokenExpireEventHandler(RefreshTokenExpireEvent event, Emitter<AuthStates> emit) async {
    try {
      const storage = FlutterSecureStorage();
      final refreshToken = await storage.read(key: 'refreshToken');
      final response = await http.post(Uri.parse(Endpoints.signup),
          body: jsonEncode(
            {"refreshToken": refreshToken},
          ));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await storage.write(key: 'accessToken', value: data['accessToken']);
        await storage.write(key: 'refreshToken', value: data['refreshToken']);
        emit(RefreshTokenExpireSuccessState());
      } else {
        emit(RefreshTokenExpireErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(RefreshTokenExpireErrorState());
    }
  }

  FutureOr<void> logOutEventHandler(LogOutEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoadingState());
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
      log("logged out...");
      emit(LogOutState());
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState());
    }
  }

  FutureOr<void> enrollFormEventHandler(EnrollFormEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoadingState());
      final url = Uri.parse(Endpoints.postProfile);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(event.formDetails);

      log(body);

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        log("success!");
        emit(LoginSuccessState());
        return;
      } else {
        emit(LoginFailureState());
      }
    } catch (e) {
      log(e.toString());
      emit(LoginFailureState());
    }
  }
}
