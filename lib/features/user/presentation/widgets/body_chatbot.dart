import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/presentation/models/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chat_bubble.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class BodyChatbot extends StatefulWidget {
  const BodyChatbot({super.key});

  @override
  State<BodyChatbot> createState() => _BodyChatbotState();
}

class _BodyChatbotState extends State<BodyChatbot> {
  late ScrollController _scrollController;
  List<MessageModel> messagesList = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _addNewMessage(String newMessage) async {
    setState(() {
      messagesList.insert(
        0,
        MessageModel(
          messageText: newMessage,
          date: DateTime.now(),
          sender: SenderType.user,
        ),
      );
    });
    final request = await Gemini.instance.prompt(
      parts: [
        Part.text(newMessage),
      ],
    );
    final response = request?.output.toString() ?? 'No response';
    setState(() {
      messagesList.insert(
        0,
        MessageModel(
          messageText: response,
          date: DateTime.now(),
          sender: SenderType.bot,
        ),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: padding(horizontal: 15),
            child: ListView.separated(
              controller: _scrollController,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemCount: messagesList.length,
              itemBuilder: (context, index) =>
                  ChatBubble(messageModel: messagesList[index]),
              separatorBuilder: (context, index) => spaceHeight(15),
            ),
          ),
        ),
        MessageInput(
          onMessageSent: (String messageText) {
            _addNewMessage(messageText);
          },
        ),
      ],
    );
  }
}
