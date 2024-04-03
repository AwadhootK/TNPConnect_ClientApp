import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tnpconnect/constants/endpoints.dart';
import 'package:tnpconnect/features/profile/bloc/models/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<GetProfileEvent>(getProfileEventHandler);
  }

  FutureOr<void> getProfileEventHandler(GetProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: "accessToken");

      log("${Endpoints.getProfile}/${event.enrollmentNo}");
      final url = Uri.parse("${Endpoints.getProfile}/${event.enrollmentNo}");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Student student = Student.fromJson(data['studentProfile']);
        Map<String, dynamic> docs = data['studentDocuments'];
        Map<String, String> studentDocs = {};

        docs.forEach(
          (key, value) {
            studentDocs[key] = value.toString();
          },
        );
        log("stud docs = $docs");

        emit(ProfileDetailsSuccessState(student, studentDocs));
      } else if (response.statusCode == 401 && jsonDecode(response.body).message == "Acess token expired!") {
        log("Access Token Expired!");
        emit(ProfileErrorState());
      } else {
        log(response.statusCode.toString());
        emit(ProfileErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(ProfileErrorState());
    }
  }
}
