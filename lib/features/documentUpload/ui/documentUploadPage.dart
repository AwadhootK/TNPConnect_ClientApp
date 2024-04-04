import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/documentUpload/bloc/document_upload_bloc.dart';
import 'package:tnpconnect/features/documentUpload/ui/pageView.dart';
import 'package:tnpconnect/features/authentication/ui/student_details_form.dart';

class DocumentsUploadPage extends StatefulWidget {
  const DocumentsUploadPage({super.key});

  @override
  State<DocumentsUploadPage> createState() => _DocumentsUploadPageState();
}

class _DocumentsUploadPageState extends State<DocumentsUploadPage> {
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

  @override
  Widget build(BuildContext context) {
    // return EnrollmentForm();
    return BlocConsumer<DocumentUploadBloc, DocumentUploadState>(
      listener: (context, state) {},
      builder: (context, state) {
        log("document state = $state");
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
                  final doc = documents[index];

                  if (state is DocumentUploadInitialState) {
                    return DocumentPageView(
                      docIndex: index,
                      documentName: doc,
                      next: () {},
                      previous: () {
                        _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                      },
                      documentUploadBloc: BlocProvider.of<DocumentUploadBloc>(context),
                      file: null,
                      numberButtonsActive: 1,
                    );
                  } else if (state is DocumentUploadUploadedState) {
                    return DocumentPageView(
                      docIndex: index,
                      documentName: doc,
                      next: () {},
                      previous: () {
                        _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                      },
                      documentUploadBloc: BlocProvider.of<DocumentUploadBloc>(context),
                      file: state.doc,
                      numberButtonsActive: 3,
                    );
                  } else if (state is DocumentUploadLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DocummentUploadErrorState) {
                    return const Center(
                      child: Text('Some error occurred...'),
                    );
                  } else if (state is DocumentUploadNextState) {
                    _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                    return Container();
                  } else if (state is DocumentUploadPreviousState) {
                    _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                    return Container();
                  } else if (state is DocumentUploadSelectedState) {
                    return DocumentPageView(
                      docIndex: index,
                      documentName: doc,
                      next: () {},
                      previous: () {
                        _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                      },
                      documentUploadBloc: BlocProvider.of<DocumentUploadBloc>(context),
                      file: state.doc,
                      numberButtonsActive: 2,
                    );
                  } else if (state is DocumentUploadVerifiedState) {
                    return DocumentPageView(
                      docIndex: index,
                      documentName: doc,
                      next: () {},
                      previous: () {
                        _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                      },
                      documentUploadBloc: BlocProvider.of<DocumentUploadBloc>(context),
                      file: state.doc,
                      numberButtonsActive: 4,
                    );
                  }
                  return null;
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
                      backgroundColor: (state is DocumentUploadUploadedState) ? Colors.blue : Colors.grey,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          if (state is DocumentUploadUploadedState && _currentPageIndex < documents.length - 1) {
                            _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
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
      },
    );
  }
}

/*
 CircleAvatar(
              child: GestureDetector(
                onTap: () {
                  if (state is DocumentUploadVerifiedState) {
                    _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn);
                  }
                },
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
*/