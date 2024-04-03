import 'package:flutter/material.dart';
import 'package:tnpconnect/features/profile/bloc/models/profile_model.dart';
import 'package:tnpconnect/features/profile/bloc/profile_bloc.dart';
import 'package:tnpconnect/features/profile/ui/profile_docs.dart';

class ProfileDetails extends StatelessWidget {
  final Student student;
  final Map<String, String> studentDocs;
  final Function() resumeAnalyze;
  final ProfileBloc profileBloc;

  const ProfileDetails(this.student, this.studentDocs, this.resumeAnalyze, this.profileBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileField('Name', student.name, Icons.person),
            buildProfileField('Enrollment No', student.enrollmentNo, Icons.confirmation_number),
            buildProfileField('Roll No', student.rollNo, Icons.assignment_ind),
            buildProfileField('Email', student.email, Icons.email),
            buildProfileField('PRN No', student.prnNo, Icons.confirmation_number),
            buildProfileField('Branch', student.branch, Icons.business),
            buildProfileField('CGPA', student.cgpa.toString(), Icons.star),
            buildProfileField('Year', student.year, Icons.calendar_today),
            buildProfileField('Count of Backlogs', student.countOfBacklogs.toString(), Icons.warning),
            buildProfileField('Interned', student.isInterned ? 'True' : 'False', Icons.work),
            buildProfileField('Gender', student.gender, Icons.person),
            buildProfileField('Company Name', student.companyName, Icons.business),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentDocumentsPage(
                          documentUrls: studentDocs,
                          resumeAnalyze: resumeAnalyze,
                          profileBloc: profileBloc,
                        ),
                      ),
                    );
                  },
                  child: const Text('View Documents')),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
