import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/documentUpload/bloc/document_upload_bloc.dart';
import 'package:tnpconnect/features/documentUpload/ui/pageView.dart';

class Details {
  int docIndex;
  PlatformFile? file;
  bool isSigned;
  double ocrMarks;
  DocumentUploadState state;

  Details({
    required this.docIndex,
    required this.file,
    required this.isSigned,
    required this.ocrMarks,
    required this.state,
  });
}

class DocumentsUploadPage extends StatefulWidget {
  const DocumentsUploadPage({super.key});

  @override
  State<DocumentsUploadPage> createState() => _DocumentsUploadPageState();
}

class _DocumentsUploadPageState extends State<DocumentsUploadPage> {
  final Map<int, Details> details = {};

  int _currentPageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<String> documents = [
    'resume',
    'marksheet',
    'tenthMarksheet',
    'twelfthMarksheet',
    'transcript',
    'collegeID',
    'aadharCard',
    'panCard',
    'passport',
    'amcatPaymentReceipt',
    'amcatResult',
    'TEfeeReceipt',
  ];

  bool _getCondition(int index, DocumentUploadState state) {
    if (details.containsKey(index)) {
      return true;
    } else {
      return (state is DocumentUploadUploadedState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentUploadBloc, DocumentUploadState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DocumentsFoundState) {
          return const Center(
            child: Text('You have already uploaded the documents!'),
          );
        } else if (state is DocumentsNotFoundState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() {
                    _currentPageIndex = index;
                  }),
                  itemBuilder: ((context, index) {
                    return DocumentPageView(docIndex: index, documentName: documents[index], details: details);
                  }),
                  itemCount: documents.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: (_currentPageIndex > 0) ? Colors.blue : Colors.grey,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          if (_currentPageIndex > 0) {
                            _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
                          }
                        },
                      ),
                    ),
                    BlocBuilder<DocumentUploadBloc, DocumentUploadState>(builder: (context, state) {
                      log("State = $state");
                      return CircleAvatar(
                        backgroundColor: _getCondition(_currentPageIndex, state) ? Colors.blue : Colors.grey,
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            if (_getCondition(_currentPageIndex, state) && _currentPageIndex < documents.length - 1) {
                              _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
                            }
                            if (details.containsKey(_currentPageIndex)) {
                              BlocProvider.of<DocumentUploadBloc>(context).add(DocumentEmitInitEvent(_currentPageIndex + 1));
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
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
