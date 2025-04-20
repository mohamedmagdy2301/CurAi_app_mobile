import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:flutter/foundation.dart';
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
        if (kDebugMode) {
          LoggerHelper.info('Message sent: $messageText');
        }
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
        padding: context.padding(horizontal: 10, vertical: 10),
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
                  fillColor: context.onSecondaryColor.withAlpha(20),
                  contentPadding: context.padding(horizontal: 20, vertical: 10),
                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(),
                  border: buildBorder(),
                  hintText: context.isStateArabic
                      ? 'ماذا يمكنني مساعدتك؟'
                      : 'What can I help you with?',
                  hintStyle: TextStyleApp.regular14().copyWith(
                    color: context.onSecondaryColor,
                  ),
                  suffixIcon: isSentMessage
                      ? null
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.attach_file,
                            color: context.primaryColor,
                          ),
                        ),
                ),
              ),
            ),
            10.wSpace,
            InkWell(
              onTap: isSentMessage ? _sendMessage : null,
              child: CircleAvatar(
                backgroundColor: context.primaryColor,
                radius: 22,
                child: isSentMessage
                    ? Icon(Icons.send, size: 22.sp, color: Colors.white)
                    : Icon(Icons.mic, size: 24.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    );
  }
}
