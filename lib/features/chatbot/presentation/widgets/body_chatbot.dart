import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/overlay_manager.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/build_chat_message.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/chat_bubble.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/message_input_chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    _scrollController.addListener(() {
      if (OverlayManager.isOverlayVisible) {
        OverlayManager.removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            context.isDark ? const Color(0xff113746) : const Color(0xffe8f1f5),
        image: DecorationImage(
          image: context.isDark
              ? const AssetImage(AppImages.splashLogoDark)
              : const AssetImage(AppImages.splashLogoLight),
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
          opacity: 0.05,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const BuildChatMessage(),
          BlocBuilder<ChatBotCubit, ChatBotState>(
            buildWhen: (previous, current) =>
                current is ChatInitLoading ||
                current is ChatInitDone ||
                current is ChatBotDone,
            builder: (context, state) {
              if (state is ChatInitLoading) {
                return const CustomLoadingWidget(height: 50, width: 50)
                    .expand();
              }
              return Expanded(
                child: Padding(
                  padding: context.padding(horizontal: 15),
                  child: BlocBuilder<ChatBotCubit, ChatBotState>(
                    builder: (context, state) {
                      final messages =
                          context.read<ChatBotCubit>().messagesList;
                      return ListView.separated(
                        controller: _scrollController,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index].sender == SenderType.bot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
              );
            },
          ),
          MessageInput(
            onMessageSent: ({String? message, XFile? image}) {
              if (image != null) {
                context.read<ChatBotCubit>().addNewMessage(image: image);
              }
              if (message != null) {
                context.read<ChatBotCubit>().addNewMessage(message: message);
              }
              _jampToLastMessage();
            },
          ),
        ],
      ),
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
