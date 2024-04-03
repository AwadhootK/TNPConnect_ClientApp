part of 'company_postings_bloc.dart';

abstract class CompanyPostingsState {}

class CompanyPostingsInitialState extends CompanyPostingsState {}

class CompanyPostingsErrorState extends CompanyPostingsState {}

class CompanyPostingsSuccessState extends CompanyPostingsState {
  List<Company> companiesList;

  CompanyPostingsSuccessState(this.companiesList);
}

class CompanyPostingsLoadingState extends CompanyPostingsState {}

class CompanyStudentRegisteredSuccessState extends CompanyPostingsState {}

class RegisteredCompaniesListState extends CompanyPostingsState {
  List<String> regCompanies = [];

  RegisteredCompaniesListState(this.regCompanies);
}
