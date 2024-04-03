import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/constants/user.dart';
import 'package:tnpconnect/features/companyPosting/bloc/company_postings_bloc.dart';
import 'package:tnpconnect/features/companyPosting/models/companyModel.dart';

class CompanyDetailsPage extends StatelessWidget {
  final Company company;
  final CompanyPostingsBloc companyBloc;

  const CompanyDetailsPage({
    super.key,
    required this.company,
    required this.companyBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Details'),
      ),
      body: BlocBuilder<CompanyPostingsBloc, CompanyPostingsState>(
        bloc: companyBloc,
        builder: (context, state) {
          if (state is CompanyStudentRegisteredSuccessState) {
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${User.instance.enrollmentNumber} successfully registered for ${company.name ?? ''}"),
                ),
              );
            });
          } else if (state is CompanyPostingsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                company.name ?? 'Company Name Not Available',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            const SizedBox(height: 16.0),
                            _buildDetailRow('Stipend', '${company.stipend ?? 0}'),
                            const Divider(),
                            _buildDetailRow('PPO', company.ppo ?? false ? 'Yes' : 'No'),
                            const Divider(),
                            _buildDetailRow('JD Link', company.jdLink ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Location', company.location ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Duration', '${company.duration ?? 'Not Available'} months'),
                            const Divider(),
                            _buildDetailRow('Rounds', '${company.rounds ?? 1}'),
                            const Divider(),
                            _buildDetailRow('Date & Time of Test', company.dateTimeOfTest ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Notes', company.notes ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Criteria', company.criteria ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Eligible Branches', (company.eligibleBranches?.map((b) => b.toString().substring(7)))?.toList().join(', ') ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Mode', company.mode ?? 'Not Available'),
                            const Divider(),
                            _buildDetailRow('Drive Completed', company.driveCompleted ?? false ? 'Yes' : 'No'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: _buildRegisterSection(context)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRegisterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 50,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Do you want to register for ${company.name}?',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Center(
            child: BlocBuilder<CompanyPostingsBloc, CompanyPostingsState>(
              bloc: companyBloc,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: state is CompanyStudentRegisteredSuccessState || (state is RegisteredCompaniesListState && state.regCompanies.contains(company.name?.toLowerCase() ?? ''))
                          ? null
                          : () {
                              if (company.name == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid Company Name!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              companyBloc.add(
                                CompanyRegisterEvent(company.name!, {
                                  //! add form for extra cols
                                }),
                              );
                            },
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 16.0),
                    OutlinedButton(
                      onPressed: state is CompanyStudentRegisteredSuccessState || (state is RegisteredCompaniesListState && state.regCompanies.contains(company.name?.toLowerCase() ?? ''))
                          ? null
                          : () {
                              // Handle No button click
                              Navigator.of(context).pop();
                            },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
