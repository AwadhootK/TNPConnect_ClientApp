part of 'company_postings_bloc.dart';

abstract class CompanyPostingsEvent {}

class GetCompanyPostingEvent extends CompanyPostingsEvent {}

class CompanyRegisterEvent extends CompanyPostingsEvent {
  String companyName;
  Map<String, dynamic> extraData;

  CompanyRegisterEvent(this.companyName, this.extraData);
}

class GetRegCompaniesEvent extends CompanyPostingsEvent {}
