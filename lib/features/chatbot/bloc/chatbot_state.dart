part of 'chatbot_bloc.dart';

abstract class ChatbotState {}

class ChatbotInitialState extends ChatbotState {}

class ChatbotLoadingState extends ChatbotState {}

class ChatbotErrorState extends ChatbotState {}

class ChatbotDataState extends ChatbotState {
  String response;

  ChatbotDataState(this.response);
}
