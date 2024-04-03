import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tnpconnect/constants/endpoints.dart';
import 'package:tnpconnect/constants/user.dart';

part 'document_upload_event.dart';
part 'document_upload_state.dart';

class DocumentUploadBloc extends Bloc<StudentDocumentUploadEvent, DocumentUploadState> {
  DocumentUploadBloc() : super(DocumentUploadInitialState(0)) {
    on<DocumentSelectEvent>(documentSelectEventHandler);
    on<DocumentUploadEvent>(documentUploadEventHandler);
    on<DocumentSignEvent>(documentSignEventHandler);
    on<DocumentVerifyEvent>(documentVerifyEventHandler);
  }

  FutureOr<void> documentSelectEventHandler(DocumentSelectEvent event, Emitter<DocumentUploadState> emit) async {
    emit(DocumentUploadLoadingState());
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      emit(DocumentUploadSelectedState(event.docIndex, file));
    } else {
      log('User cancelled the picker');
      emit(DocummentUploadErrorState());
    }
  }

  Future<io.File?> pickAndConvertImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }

    return io.File(pickedFile.path);
  }

  Future<void> documentUploadEventHandler(DocumentUploadEvent event, Emitter<DocumentUploadState> emit) async {
    try {
      emit(DocumentUploadLoadingState());

      final url = Uri.parse(Endpoints.uploadDocFlask);

      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      if (event.file.path == null) {
        log("path null");
        return;
      }

      io.File file = io.File(event.file.path!);
      io.File image = (await pickAndConvertImage())!;

      log("file = ${image.path}");

      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: event.file.name,
          contentType: MediaType('application', 'pdf'),
        ),
      );

      request.files.add(
        http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: "signature",
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.fields['erno'] = User.instance.enrollmentNumber;
      request.fields['docType'] = event.docIndex.toString();

      final response = await request.send();

      inspect(response);

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();

        final downloadURL = jsonDecode(responseBody)['downloadUrl'];

        log(downloadURL);

        final url2 = Uri.parse("${Endpoints.uploadDocNode}/${User.instance.enrollmentNumber}/${event.docIndex}");
        final headers2 = {'Content-Type': 'application/json'};
        final body2 = jsonEncode({"downloadURL": downloadURL});

        log(url2.toString());

        final res = await http.post(url2, headers: headers2, body: body2);

        if (res.statusCode == 200) {
          final data2 = jsonDecode(res.body);

          log(data2.toString());

          emit(DocumentUploadUploadedState(event.docIndex, event.file));
          return;
        }
        emit(DocummentUploadErrorState());
        return;
      } else {
        emit(DocummentUploadErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(DocummentUploadErrorState());
    }
  }

  FutureOr<void> documentSignEventHandler(DocumentSignEvent event, Emitter<DocumentUploadState> emit) {
    try {
      emit(DocumentUploadLoadingState());

      // req

      emit(DocumentUploadSignedState(event.docIndex, event.file));
    } catch (e) {
      log(e.toString());
      emit(DocummentUploadErrorState());
    }
  }

  FutureOr<void> documentVerifyEventHandler(DocumentVerifyEvent event, Emitter<DocumentUploadState> emit) {
    try {
      emit(DocumentUploadLoadingState());

      // req

      emit(DocumentUploadVerifiedState(event.docIndex, event.file));
    } catch (e) {
      log(e.toString());
      emit(DocummentUploadErrorState());
    }
  }
}
