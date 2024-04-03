part of 'chatbot_bloc.dart';

abstract class ChatBotEvent {}

class ChatBotPostEvent extends ChatBotEvent {
  String request;

  ChatBotPostEvent(this.request);
}
