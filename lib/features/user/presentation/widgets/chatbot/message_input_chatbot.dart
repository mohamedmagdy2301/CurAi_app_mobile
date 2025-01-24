import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/helper/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    required this.onMessageSent,
    super.key,
  });

  final void Function(String message) onMessageSent;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controllerMessage = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSentMessage = false;

  @override
  void dispose() {
    _controllerMessage.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final messageText = _controllerMessage.text.trim();
      if (messageText.isNotEmpty) {
        widget.onMessageSent(messageText);
        LoggerHelper.info('Message sent: $messageText');
        _controllerMessage.clear();
        setState(() {
          isSentMessage = false;
        });
        hideKeyboard();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: padding(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controllerMessage,
                onChanged: (value) {
                  setState(() => isSentMessage = value.trim().isNotEmpty);
                },
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.color.onSecondary.withAlpha(20),
                  contentPadding: padding(horizontal: 20, vertical: 10),
                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(),
                  border: buildBorder(),
                  hintText: context.isStateArabic
                      ? 'ماذا يمكنني مساعدتك؟'
                      : 'What can I help you with?',
                  hintStyle: context.styleRegular14.copyWith(
                    color: context.color.onSecondary,
                  ),
                  suffixIcon: isSentMessage
                      ? null
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.attach_file,
                            color: context.color.onSecondary,
                          ),
                        ),
                ),
              ),
            ),
            spaceWidth(10),
            InkWell(
              onTap: isSentMessage ? _sendMessage : null,
              child: CircleAvatar(
                backgroundColor: context.color.primary,
                radius: 22.r,
                child: isSentMessage
                    ? Icon(Icons.send, size: 18.sp)
                    : Icon(Icons.mic, size: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      borderSide: BorderSide.none,
    );
  }
}
