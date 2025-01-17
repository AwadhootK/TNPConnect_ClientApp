part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {
  String enrollmentNo;

  GetProfileEvent(this.enrollmentNo);
}

class AnalyzeResumeEvent extends ProfileEvent {
  String resumeURL;

  AnalyzeResumeEvent(this.resumeURL);
}
