import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/cubit/chat_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chat_bubble.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyChatbot extends StatelessWidget {
  const BodyChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: padding(horizontal: 15),
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final messages = context.read<ChatCubit>().messagesList;
                return ListView.separated(
                  controller: ScrollController(),
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
          },
        ),
      ],
    );
  }
}
