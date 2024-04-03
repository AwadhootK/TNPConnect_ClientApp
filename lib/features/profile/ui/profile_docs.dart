import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDocumentsPage extends StatelessWidget {
  final Map<String, String> documentUrls;

  const StudentDocumentsPage({Key? key, required this.documentUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Documents'),
      ),
      body: Container(
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
              tileColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Text(
                documentName,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _launchUrl('https://www.google.com/'),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String? url) async {
    log(url!);
    if (!(await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication))) {
      throw 'Could not launch $url';
    }
  }
}
