import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tnpconnect/constants/endpoints.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatBotEvent, ChatbotState> {
  ChatbotBloc() : super(ChatbotInitialState()) {
    on<ChatBotPostEvent>(chatBotPostEventHandler);
  }

  FutureOr<void> chatBotPostEventHandler(ChatBotPostEvent event, Emitter<ChatbotState> emit) async {
    try {
      emit(ChatbotLoadingState());

      final url = Uri.parse(Endpoints.chatbotAsk);
      final body = jsonEncode({"question": event.request});
      final headers = {'Content-Type': 'application/json'};

      log("question: $body");

      final response = await http.post(url, headers: headers, body: body);
      inspect(response);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        log("Answer = ${body['answer']}");

        emit(ChatbotDataState(body['answer']));
      } else {
        log("error occurred...");
      }
    } catch (e) {
      log(e.toString());
      emit(ChatbotErrorState());
    }
  }
}
