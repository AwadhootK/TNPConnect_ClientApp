part of 'document_upload_bloc.dart';

abstract class StudentDocumentUploadEvent {}

class DocumentSelectEvent extends StudentDocumentUploadEvent {
  int docIndex;

  DocumentSelectEvent(this.docIndex);
}

class DocumentUploadEvent extends StudentDocumentUploadEvent {
  int docIndex;
  PlatformFile file;

  DocumentUploadEvent(this.docIndex, this.file);
}

class DocumentSignEvent extends StudentDocumentUploadEvent {
  int docIndex;
  PlatformFile file;

  DocumentSignEvent(this.docIndex, this.file);
}

class DocumentVerifyEvent extends StudentDocumentUploadEvent {
  int docIndex;
  PlatformFile file;

  DocumentVerifyEvent(this.docIndex, this.file);
}

class DocumentEmitInitEvent extends StudentDocumentUploadEvent {
  int docIndex;

  DocumentEmitInitEvent(this.docIndex);
}

class CheckDocsUploaded extends StudentDocumentUploadEvent {
  String erno;

  CheckDocsUploaded(this.erno);
}
