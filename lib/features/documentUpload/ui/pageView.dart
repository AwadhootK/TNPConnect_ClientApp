import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tnpconnect/features/documentUpload/bloc/document_upload_bloc.dart';

class DocumentPageView extends StatefulWidget {
  final int docIndex;
  final String documentName;
  final Function() next;
  final Function() previous;
  final DocumentUploadBloc documentUploadBloc;
  final PlatformFile? file;
  final int numberButtonsActive;
  final bool? isSignVerified;
  final double? ocrMarks;
  final DocumentUploadState documentUploadState;

  const DocumentPageView({
    Key? key,
    required this.docIndex,
    required this.documentName,
    required this.next,
    required this.previous,
    required this.documentUploadBloc,
    required this.file,
    required this.numberButtonsActive,
    required this.isSignVerified,
    required this.ocrMarks,
    required this.documentUploadState,
  }) : super(key: key);

  @override
  _DocumentPageViewState createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildDocumentCard(),
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
                onPressed: widget.numberButtonsActive < 1
                    ? null
                    : () async {
                        widget.documentUploadBloc.add(DocumentSelectEvent(widget.docIndex));
                      },
                child: const Text('Select Document'),
              ),
              ElevatedButton(
                onPressed: widget.numberButtonsActive < 2
                    ? null
                    : () {
                        if (widget.file != null) {
                          widget.documentUploadBloc.add(DocumentUploadEvent(widget.docIndex, widget.file!));
                        }
                      },
                child: const Text('Upload Document'),
              ),
              // ElevatedButton(
              //   onPressed: widget.numberButtonsActive < 3
              //       ? null
              //       : () {
              //           if (widget.file != null) {
              //             widget.documentUploadBloc.add(DocumentSignEvent(widget.docIndex, widget.file!));
              //           }
              //         },
              //   child: const Text(
              //     'Add Signature',
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: widget.numberButtonsActive < 4
              //       ? null
              //       : () {
              //           if (widget.file != null) {
              //             widget.documentUploadBloc.add(DocumentVerifyEvent(widget.docIndex, widget.file!));
              //           }
              //         },
              //   child: const Text(
              //     'Verify Signature',
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
            ],
          ),
          if (widget.documentUploadState is DocumentUploadUploadedState && (widget.isSignVerified ?? false) == true)
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

  Widget _buildDocumentCard() {
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
              (widget.file != null) ? widget.file?.name ?? 'No name' : 'No document selected',
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
