part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class ProfileDetailsSuccessState extends ProfileState {
  Student student;
  Map<String, String> studentDocs;

  ProfileDetailsSuccessState(this.student, this.studentDocs);
}

class ResumeAnalysisState extends ProfileState {
  AnalyzeResumeModel analysis;

  ResumeAnalysisState(this.analysis);
}
