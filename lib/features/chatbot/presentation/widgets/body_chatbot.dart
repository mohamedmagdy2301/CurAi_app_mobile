import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/build_chat_message.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/chat_bubble.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/message_input_chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class BodyChatbot extends StatefulWidget {
//   const BodyChatbot({super.key});

//   @override
//   State<BodyChatbot> createState() => _BodyChatbotState();
// }

// class _BodyChatbotState extends State<BodyChatbot> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     // إرسال رسالة الترحيب عند فتح الشات
//     context.read<ChatBotCubit>().addWelcomeMessage();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         const BuildChatMessage(),
//         Expanded(
//           child: Padding(
//             padding: context.padding(horizontal: 15),
//             child: BlocBuilder<ChatBotCubit, ChatBotState>(
//               builder: (context, state) {
//                 final messages = context.read<ChatBotCubit>().messagesList;
//                 return ListView.separated(
//                   controller: _scrollController,
//                   reverse: true,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) => ChatBubble(
//                     messageModel: messages[index],
//                   ),
//                   separatorBuilder: (context, index) => 15.hSpace,
//                 );
//               },
//             ),
//           ),
//         ),
//         MessageInput(
//           onMessageSent: (String messageText) {
//             context.read<ChatBotCubit>().addNewMessage(messageText);
//             _jumpToLastMessage();
//           },
//         ),
//       ],
//     );
//   }

//   Future<void> _jumpToLastMessage() async {
//     await _scrollController.animateTo(
//       0,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }
// }
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
    // إرسال رسالة الترحيب عند فتح الشات
    context.read<ChatBotCubit>().addWelcomeMessage();
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
            padding: context.padding(horizontal: 15),
            child: BlocBuilder<ChatBotCubit, ChatBotState>(
              builder: (context, state) {
                final messages = context.read<ChatBotCubit>().messagesList;
                return ListView.separated(
                  controller: _scrollController,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (messages[index].sender == SenderType.bot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ChatBubble(messageModel: messages[index]),
                        ],
                      );
                    } else {
                      return ChatBubble(messageModel: messages[index]);
                    }
                  },
                  separatorBuilder: (context, index) => 15.hSpace,
                );
              },
            ),
          ),
        ),
        MessageInput(
          onMessageSent: (String messageText) {
            context.read<ChatBotCubit>().addNewMessage(messageText);
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
