import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/companyPosting/bloc/company_postings_bloc.dart';
import 'package:tnpconnect/features/companyPosting/ui/companyDetailPage.dart';
import 'package:tnpconnect/features/companyPosting/ui/companyPostingWidget.dart';

class CompanyPostingsPage extends StatelessWidget {
  const CompanyPostingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyPostingsBloc, CompanyPostingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = BlocProvider.of<CompanyPostingsBloc>(context);
        if (state is CompanyPostingsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CompanyPostingsErrorState) {
          return const Center(
            child: Text('Some error occurred...'),
          );
        } else if (state is CompanyPostingsSuccessState) {
          return ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CompanyDetailsPage(
                      companyBloc: bloc..add(GetRegCompaniesEvent()),
                      company: state.companiesList[index],
                    ),
                  ),
                );
              },
              child: CompanyPostingWidget(
                companyName: state.companiesList[index].name ?? 'No name',
                role: state.companiesList[index].location ?? 'No location',
                stipend: state.companiesList[index].stipend.toString(),
                logoUrl: state.companiesList[index].mode ?? 'No mode',
              ),
            ),
            itemCount: state.companiesList.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
