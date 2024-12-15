import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/presentation/models/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chat_bubble.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';

class BodyChatbot extends StatefulWidget {
  const BodyChatbot({super.key});

  @override
  State<BodyChatbot> createState() => _BodyChatbotState();
}

class _BodyChatbotState extends State<BodyChatbot> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize the ScrollController
    _scrollController = ScrollController();
    // Scroll to the bottom when the widget is first built
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    // Dispose of the ScrollController to avoid memory leaks
    _scrollController.dispose();
    super.dispose();
  }

  List<MessageModel> getMessagesList() {
    if (isArabic()) {
      return messagesListArabic.reversed.toList();
    } else {
      return messagesListEnglish.reversed.toList();
    }
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

  void _addNewMessage(MessageModel newMessage) {
    setState(() {
      if (isArabic()) {
        messagesListArabic.add(newMessage);
      } else {
        messagesListEnglish.add(newMessage);
      }
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
              itemCount: getMessagesList().length,
              itemBuilder: (context, index) =>
                  ChatBubble(messageModel: getMessagesList()[index]),
              separatorBuilder: (context, index) => spaceHeight(15),
            ),
          ),
        ),
        MessageInput(
          onMessageSent: (String messageText) {
            _addNewMessage(
              MessageModel(
                messageText: messageText,
                date: DateTime.now(),
                sender: SenderType.user,
              ),
            );
          },
        ),
      ],
    );
  }
}
