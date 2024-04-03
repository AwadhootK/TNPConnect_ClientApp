import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/chatbot/bloc/chatbot_bloc.dart';
import 'package:tnpconnect/features/chatbot/ui/chatbubble.dart';
import 'package:tnpconnect/features/chatbot/ui/chatloadingbubble.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();

  List<String> conversations = [];

  void _sendMessage(String message, BuildContext context) async {
    conversations.add(message);
    BlocProvider.of<ChatbotBloc>(context).add(ChatBotPostEvent(message));
    _controller.clear();
  }

  Widget buildChatInput() {
    return Container(
      color: Colors.blue.shade100,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {
              _sendMessage(_controller.text, context);
            },
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatbotBloc, ChatbotState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatbotLoadingState) {
          conversations.add('loader');
        } else if (state is ChatbotDataState) {
          conversations.removeWhere((element) => element == 'loader');
          conversations.add(state.response);
        } else if (state is ChatbotErrorState) {
          conversations.add("Some error occurred...");
        }
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    if (conversations[index] == 'loader') {
                      return const ChatLoadingBubble();
                    }
                    return ChatBubble(
                      message: conversations[index],
                      isUser: index % 2 == 0,
                    );
                  },
                ),
              ),
            ),
            buildChatInput(),
          ],
        );
      },
    );
  }
}
