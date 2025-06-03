import 'dart:io';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/features/chatbot/data/datasources/chatbot_remote_data_source.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    required this.onMessageSent,
    super.key,
  });

  final void Function({String? message, XFile? image}) onMessageSent;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controllerMessage = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSentMessage = false;
  XFile image = XFile('');
  @override
  void dispose() {
    _controllerMessage.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (image.path.isNotEmpty) {
      widget.onMessageSent(image: image);
      setState(() {
        image = XFile('');
        isSentMessage = false;
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final messageText = _controllerMessage.text.trim();
      if (messageText.isNotEmpty) {
        widget.onMessageSent(message: messageText);
        _controllerMessage.clear();
        setState(() => isSentMessage = false);
        hideKeyboard();
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    image = await picker.pickImage(source: source) ?? XFile('');
    if (image.path.isNotEmpty) {
      setState(() {
        isSentMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Icon(
                  CupertinoIcons.add_circled_solid,
                  size: 32.sp,
                  color: context.onPrimaryColor,
                ),
                onTap: () {
                  AdaptiveDialogs.showOkAlertDialog(
                    context: context,
                    title: context.isStateArabic
                        ? 'بدء محادثة جديدة'
                        : 'Start a new conversation',
                    message: context.isStateArabic
                        ? Text(
                            'هل تريد بدء محادثة جديدة؟'
                            '\nسوف يتم حذف المحادثة الحالية',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onSecondaryColor,
                            ),
                          )
                        : Text(
                            'Do you want to start a new conversation?'
                            '\nThe current conversation will be deleted',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onSecondaryColor,
                            ),
                          ),
                    onPressed: () {
                      hideKeyboard();
                      context.read<ChatBotCubit>()
                        ..clearChatBot()
                        ..addWelcomeMessage();

                      context.pop();
                    },
                  );
                },
              ),
              6.hSpace,
            ],
          ),
          5.wSpace,
          if (image.path.isNotEmpty)
            Container(
              width: context.W * 0.7,
              height: context.H * 0.06,
              decoration: BoxDecoration(
                color: context.onSecondaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: context.padding(horizontal: 10, vertical: 5),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(image.path),
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          image = XFile('');
                          isSentMessage = false;
                        });
                      },
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: TextFormField(
                controller: _controllerMessage,
                onChanged: (value) {
                  setState(() => isSentMessage = value.trim().isNotEmpty);
                },
                minLines: 1,
                maxLines: 6,
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
                          onPressed: () {
                            showBottomSheetSelectImage(context);
                          },
                          icon: Icon(
                            CupertinoIcons.photo,
                            size: 23.sp,
                            color: context.onSecondaryColor,
                          ),
                        ),
                ),
              ),
            ),
          10.wSpace,
          InkWell(
            onTap: (serverAddress.isNotEmpty && isSentMessage)
                ? _sendMessage
                : null,
            child: CircleAvatar(
              backgroundColor: (serverAddress.isNotEmpty && isSentMessage)
                  ? context.primaryColor
                  : Colors.grey,
              radius: 23.r,
              child: Icon(
                CupertinoIcons.paperplane,
                size: 23.sp,
                color: (serverAddress.isNotEmpty && isSentMessage)
                    ? Colors.white
                    : Colors.grey[200],
              ),
            ),
          ),
        ],
      )
          .paddingSymmetric(horizontal: 5, vertical: 10)
          .paddingBottom(Platform.isIOS ? 10 : 0),
    );
  }

  Future<void> showBottomSheetSelectImage(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(CupertinoIcons.photo),
                title: Text(
                  context.isStateArabic ? 'اختر صورة' : 'Choose a photo',
                  style: TextStyleApp.bold16().copyWith(
                    color: context.onSecondaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(CupertinoIcons.camera),
                title: Text(
                  context.isStateArabic ? 'التقاط صورة' : 'Take a photo',
                  style: TextStyleApp.bold16().copyWith(
                    color: context.onSecondaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ).paddingSymmetric(
            vertical: 20,
            horizontal: 20,
          ),
        );
      },
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    );
  }
}
