part of 'document_upload_bloc.dart';

abstract class DocumentUploadState {}

class DocumentUploadInitialState extends DocumentUploadState {
  int docIndex;

  DocumentUploadInitialState(this.docIndex);
}

class DocumentUploadLoadingState extends DocumentUploadState {}

class DocummentUploadErrorState extends DocumentUploadState {}

class DocumentUploadSelectedState extends DocumentUploadState {
  int docIndex;
  final PlatformFile doc;

  DocumentUploadSelectedState(
    this.docIndex,
    this.doc,
  );
}

class DocumentUploadUploadedState extends DocumentUploadState {
  int docIndex;
  bool isSigned;
  double? ocrMarks;
  final PlatformFile doc;

  DocumentUploadUploadedState(
    this.docIndex,
    this.doc,
    this.isSigned,
    this.ocrMarks,
  );
}

class DocumentUploadSignedState extends DocumentUploadState {
  int docIndex;
  final PlatformFile doc;

  DocumentUploadSignedState(this.docIndex, this.doc);
}

class DocumentUploadVerifiedState extends DocumentUploadState {
  int docIndex;
  final PlatformFile doc;

  DocumentUploadVerifiedState(this.docIndex, this.doc);
}

class DocumentUploadNextState extends DocumentUploadState {
  int docIndex;

  DocumentUploadNextState(this.docIndex);
}

class DocumentUploadPreviousState extends DocumentUploadState {
  int docIndex;

  DocumentUploadPreviousState(this.docIndex);
}

class DocumentsFoundState extends DocumentUploadState {}

class DocumentsNotFoundState extends DocumentUploadState {}
