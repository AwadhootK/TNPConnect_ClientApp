import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tnpconnect/constants/endpoints.dart';
import 'package:tnpconnect/constants/user.dart';
import 'package:tnpconnect/features/companyPosting/models/companyModel.dart';

part 'company_postings_event.dart';
part 'company_postings_state.dart';

class CompanyPostingsBloc extends Bloc<CompanyPostingsEvent, CompanyPostingsState> {
  CompanyPostingsBloc() : super(CompanyPostingsInitialState()) {
    on<GetCompanyPostingEvent>(getCompanyPostingEventHandler);
    on<CompanyRegisterEvent>(companyRegisterEventHandler);
    on<GetRegCompaniesEvent>(getRegCompaniesEventHandler);
  }

  FutureOr<void> getCompanyPostingEventHandler(GetCompanyPostingEvent event, Emitter<CompanyPostingsState> emit) async {
    try {
      emit(CompanyPostingsLoadingState());
      final url = Uri.parse(Endpoints.getCompanyPostings);
      final headers = {'Content-Type': 'application/json'};

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<Company> companiesList = [];
        data['companies'].forEach((company) {
          companiesList.add(
            Company.fromJson(company),
          );
        });

        log(companiesList.length.toString());

        emit(CompanyPostingsSuccessState(companiesList));
        return;
      }

      emit(CompanyPostingsErrorState());
    } catch (e) {
      log(e.toString());
      emit(CompanyPostingsErrorState());
    }
  }

  FutureOr<void> companyRegisterEventHandler(CompanyRegisterEvent event, Emitter<CompanyPostingsState> emit) async {
    try {
      emit(CompanyPostingsLoadingState());
      final url = Uri.parse("${Endpoints.companyRegisterEvent}?studentID=${User.instance.enrollmentNumber}&companyName=${event.companyName}");
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(event.extraData);

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        log("success!");
        emit(CompanyStudentRegisteredSuccessState());
        return;
      } else {
        emit(CompanyPostingsErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(CompanyPostingsErrorState());
    }
  }

  FutureOr<void> getRegCompaniesEventHandler(GetRegCompaniesEvent event, Emitter<CompanyPostingsState> emit) async {
    try {
      emit(CompanyPostingsLoadingState());
      final url = Uri.parse("${Endpoints.getRegCompanies}/${User.instance.enrollmentNumber}");
      final headers = {'Content-Type': 'application/json'};

      log("${Endpoints.getRegCompanies}/${User.instance.enrollmentNumber}");

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['companies'];
        List<String> companies = [];

        data.forEach((c) {
          if (!companies.contains(c.toString().toLowerCase())) {
            companies.add(c.toString().toLowerCase());
          }
        });

        emit(RegisteredCompaniesListState(companies));
        return;
      } else {
        emit(CompanyPostingsErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(CompanyPostingsErrorState());
    }
  }
}
