import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/chat_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/build_chat_message.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/chat_bubble.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/message_input_chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyChatbot extends StatefulWidget {
  const BodyChatbot({super.key});

  @override
  State<BodyChatbot> createState() => _BodyChatbotState();
}

class _BodyChatbotState extends State<BodyChatbot> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const BuildChatMessage(),
        Expanded(
          child: Padding(
            padding: padding(horizontal: 15),
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final messages = context.read<ChatCubit>().messagesList;
                return ListView.separated(
                  controller: _scrollController,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ChatBubble(
                    messageModel: messages[index],
                  ),
                  separatorBuilder: (context, index) => spaceHeight(15),
                );
              },
            ),
          ),
        ),
        MessageInput(
          onMessageSent: (String messageText) {
            context.read<ChatCubit>().addNewMessage(messageText);
            _jampToLastMessage();
          },
        ),
      ],
    );
  }

  Future<void> _jampToLastMessage() async {
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
