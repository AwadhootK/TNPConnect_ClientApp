import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/profile/bloc/models/resume_model.dart';
import 'package:tnpconnect/features/profile/bloc/profile_bloc.dart';
import 'package:tnpconnect/features/profile/ui/resume_analysis_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDocumentsPage extends StatelessWidget {
  final Map<String, String> documentUrls;
  final Function() resumeAnalyze;
  final ProfileBloc profileBloc;

  const StudentDocumentsPage({
    Key? key,
    required this.documentUrls,
    required this.resumeAnalyze,
    required this.profileBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Documents'),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) {
          if (state is ResumeAnalysisState) {
            _showResumeAnalysisDialog(context, state.analysis);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileErrorState) {
            return const Center(
              child: Text('Some error occurred!'),
            );
          }
          return _buildDocumentList(context);
        },
      ),
    );
  }

  Widget _buildDocumentList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: documentUrls.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final documentName = documentUrls.keys.elementAt(index);
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              child: const Icon(
                Icons.file_copy_outlined,
                color: Colors.blue,
              ),
            ),
            tileColor: Colors.blue.shade100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text(
              documentName[0].toUpperCase() + documentName.substring(1),
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            trailing: documentName.toLowerCase() == 'resume'
                ? SizedBox(
                    width: 110,
                    child: Row(
                      children: [
                        OutlinedButton(onPressed: resumeAnalyze, child: const Text('Analyze')),
                        const Icon(Icons.arrow_forward_ios),
                        const SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                  )
                : const Icon(Icons.arrow_forward_ios),
            onTap: () => _launchUrl(documentUrls[documentName]),
          );
        },
      ),
    );
  }

  void _showResumeAnalysisDialog(BuildContext context, AnalyzeResumeModel resumeAnalysis) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResumeAnalysisDialog(resumeModel: resumeAnalysis);
      },
    );
  }

  Future<void> _launchUrl(String? url) async {
    log(url!);
    if (!(await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication))) {
      throw 'Could not launch $url';
    }
  }
}
