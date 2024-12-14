import 'package:curai_app_mobile/features/user/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';

class BodyChatbot extends StatelessWidget {
  const BodyChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
        ),
        const MessageInput(),
      ],
    );
  }
}
