import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/documentUpload/bloc/document_upload_bloc.dart';
import 'package:tnpconnect/features/documentUpload/ui/documentUploadPage.dart';

class DocumentPageView extends StatefulWidget {
  final int docIndex;
  final String documentName;
  final Map<int, Details> details;

  const DocumentPageView({
    Key? key,
    required this.docIndex,
    required this.documentName,
    required this.details,
  }) : super(key: key);

  @override
  _DocumentPageViewState createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
  void printMap() {
    log("Details Map");
    widget.details.forEach((key, value) {
      log("key = $key");
      log("index = ${value.docIndex}");
      log("isSigned${value.isSigned}");
      log("state = ${value.state}");
      log("ocr = ${value.ocrMarks}");
    });
  }

  @override
  Widget build(BuildContext context) {
    printMap();
    return BlocConsumer<DocumentUploadBloc, DocumentUploadState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DocumentUploadLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DocummentUploadErrorState) {
          return const Center(
            child: Text('Some error occurred...'),
          );
        } else if (state is DocumentUploadInitialState) {
          log("state.docIndex = ${widget.docIndex}");
          if (widget.details.containsKey(widget.docIndex)) {
            return _buildPage(
              widget.details[widget.docIndex]!.file,
              widget.docIndex,
              BlocProvider.of<DocumentUploadBloc>(context),
              2,
              widget.details[widget.docIndex]!.state,
              widget.details[widget.docIndex]!.isSigned,
              widget.details[widget.docIndex]!.ocrMarks,
            );
          }
          return _buildPage(null, state.docIndex, BlocProvider.of<DocumentUploadBloc>(context), 1, state, null, null);
        } else if (state is DocumentUploadUploadedState) {
          if (widget.details.containsKey(state.docIndex)) {
            return _buildPage(
              widget.details[state.docIndex]?.file,
              state.docIndex,
              BlocProvider.of<DocumentUploadBloc>(context),
              2,
              widget.details[state.docIndex]!.state,
              widget.details[state.docIndex]?.isSigned,
              widget.details[state.docIndex]?.ocrMarks,
            );
          }
          if (!widget.details.containsKey(state.docIndex)) {
            log("inserting widget.details");
            widget.details[state.docIndex] = Details(
              docIndex: state.docIndex,
              file: state.doc,
              isSigned: state.isSigned,
              ocrMarks: state.ocrMarks ?? 0.0,
              state: state,
            );
            printMap();
          }
          return _buildPage(
            state.doc,
            state.docIndex,
            BlocProvider.of<DocumentUploadBloc>(context),
            2,
            state,
            state.isSigned,
            state.ocrMarks,
          );
        } else if (state is DocumentUploadSignedState) {
          if (widget.details.containsKey(state.docIndex)) {
            return _buildPage(
              widget.details[state.docIndex]?.file,
              state.docIndex,
              BlocProvider.of<DocumentUploadBloc>(context),
              2,
              widget.details[state.docIndex]!.state,
              widget.details[state.docIndex]?.isSigned,
              widget.details[state.docIndex]?.ocrMarks,
            );
          }
          return _buildPage(state.doc, state.docIndex, BlocProvider.of<DocumentUploadBloc>(context), 3, state, null, null);
        } else if (state is DocumentUploadVerifiedState) {
          if (widget.details.containsKey(state.docIndex)) {
            return _buildPage(
              widget.details[state.docIndex]?.file,
              state.docIndex,
              BlocProvider.of<DocumentUploadBloc>(context),
              2,
              widget.details[state.docIndex]!.state,
              widget.details[state.docIndex]?.isSigned,
              widget.details[state.docIndex]?.ocrMarks,
            );
          }
          return _buildPage(state.doc, state.docIndex, BlocProvider.of<DocumentUploadBloc>(context), 4, state, null, null);
        } else if (state is DocumentUploadSelectedState) {
          if (widget.details.containsKey(state.docIndex)) {
            return _buildPage(
              widget.details[state.docIndex]?.file,
              state.docIndex,
              BlocProvider.of<DocumentUploadBloc>(context),
              2,
              widget.details[state.docIndex]!.state,
              widget.details[state.docIndex]?.isSigned,
              widget.details[state.docIndex]?.ocrMarks,
            );
          }
          return _buildPage(state.doc, state.docIndex, BlocProvider.of<DocumentUploadBloc>(context), 2, state, null, null);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildPage(
    PlatformFile? file,
    int docIndex,
    DocumentUploadBloc documentUploadBloc,
    int numberButtonsActive,
    DocumentUploadState documentUploadState,
    bool? isSignVerified,
    double? ocrMarks,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildDocumentCard(file),
          const SizedBox(height: 20.0),
          const Divider(
            color: Color.fromARGB(255, 146, 105, 105),
            height: 20,
          ),
          const SizedBox(height: 10.0),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 5,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: [
              ElevatedButton(
                onPressed: numberButtonsActive < 1
                    ? null
                    : () async {
                        documentUploadBloc.add(DocumentSelectEvent(docIndex));
                      },
                child: const Text('Select Document'),
              ),
              ElevatedButton(
                onPressed: numberButtonsActive < 2
                    ? null
                    : () {
                        if (file != null) {
                          documentUploadBloc.add(DocumentUploadEvent(docIndex, file));
                        }
                      },
                child: const Text('Upload Document'),
              ),
            ],
          ),
          if (documentUploadState is DocumentUploadUploadedState && (isSignVerified ?? false) == true)
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildDocumentCard(PlatformFile? file) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Icon(
              Icons.description,
              color: Color(0xFF0D47A1), // Dark blue color
              size: 40.0,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Expected Document:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF424242), // Dark grey color
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.documentName,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            const Divider(
              color: Color(0xFF424242), // Dark grey color
              height: 20,
            ),
            const Text(
              'Selected Document:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF424242), // Dark grey color
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              (file != null) ? file.name ?? 'No name' : 'No document selected',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
