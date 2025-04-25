import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDialogs {
  /// Show an alert
  static Future<void> showLoadingAlertDialog({
    required BuildContext context,
    required String title,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: '$title...',
      message: const CustomLoadingWidget(
        width: 40,
        height: 40,
      ),
      actions: [],
    );
  }

  /// Show an alert with only an "OK" button.
  static Future<void> showAlertDialogWithWidget({
    required BuildContext context,
    required String title,
    required Widget widget,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: widget,
      actions: [],
    );
  }

  /// Show an alert with only an "Logout" button.
  static Future<void> showLogoutAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    void Function()? onPressed,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: Text(
        message,
        style: TextStyleApp.medium14().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      actions: [
        _buildDialogAction(
          context,
          text: context.translate(LangKeys.login),
          onPressed: onPressed ?? () {},
        ),
      ],
    );
  }

  /// Show an alert with only an "OK" button.
  static Future<void> showOkAlertDialog({
    required BuildContext context,
    required String title,
    required Widget message,
    void Function()? onPressed,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: message,
      actions: [
        _buildDialogAction(
          context,
          text: context.translate(LangKeys.ok),
          onPressed: onPressed ?? () {},
        ),
      ],
    );
  }

  /// Show an alert with "OK" and "Cancel" buttons.
  static Future<bool?> showOkCancelAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    void Function()? onPressedOk,
    void Function()? onPressedCancel,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: Text(
        message,
        style: TextStyleApp.medium14().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      actions: [
        _buildDialogAction(
          context,
          text: context.translate(LangKeys.cancel),
          onPressed: onPressedCancel ?? () => context.pop(),
        ),
        _buildDialogAction(
          context,
          text: context.translate(LangKeys.ok),
          isDefaultAction: true,
          onPressed: onPressedOk ?? () => context.pop(),
        ),
      ],
    );
  }

  /// Show a confirmation dialog with customizable actions.
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required Widget message,
    required String confirmText,
    required String cancelText,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: message,
      actions: [
        _buildDialogAction(
          context,
          text: cancelText,
          onPressed: () => context.popWithValue(false),
        ),
        _buildDialogAction(
          context,
          text: confirmText,
          isDefaultAction: true,
          onPressed: () => context.popWithValue(true),
        ),
      ],
    );
  }

  /// Show a modal action sheet (for iOS and Android).
  static Future<void> showModalActionSheet({
    required BuildContext context,
    required String title,
    required List<String> actions,
    required ValueChanged<int> onSelected,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              title,
              style: TextStyleApp.bold16().copyWith(
                color: context.onPrimaryColor,
              ),
            ),
            actions: actions.asMap().entries.map((entry) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  context.pop();
                  onSelected(entry.key);
                },
                child: Text(entry.value),
              );
            }).toList(),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => context.pop(),
              child: Text(
                context.translate(LangKeys.cancel),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      );
    } else {
      // Android-style bottom sheet
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              ...actions.asMap().entries.map((entry) {
                return ListTile(
                  title: Text(
                    entry.value,
                    style: TextStyleApp.bold16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                  onTap: () {
                    context.pop();
                    onSelected(entry.key);
                  },
                );
              }),
              ListTile(
                title: Text(
                  context.translate(LangKeys.cancel),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => context.pop(),
              ),
            ],
          );
        },
      );
    }
  }

  /// Show a text input dialog (for collecting user input).
  static Future<String?> showTextInputDialog({
    required BuildContext context,
    required String title,
    required String hintText,
    required String confirmText,
  }) async {
    final textController = TextEditingController();
    String? userInput;

    await _showPlatformDialog<void>(
      context: context,
      title: title,
      message: const Text(''),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: hintText),
      ),
      actions: [
        _buildDialogAction(
          context,
          text: context.translate(LangKeys.cancel),
          onPressed: () => context.pop(),
        ),
        _buildDialogAction(
          context,
          text: confirmText,
          isDefaultAction: true,
          onPressed: () {
            userInput = textController.text;
            context.popWithValue(userInput);
          },
        ),
      ],
    );
    return userInput;
  }

  /// Internal function to handle platform-adapted dialogs.
  static Future<T?> _showPlatformDialog<T>({
    required BuildContext context,
    required String title,
    required Widget message,
    required List<Widget> actions,
    Widget? content,
  }) {
    return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyleApp.bold16().copyWith(
                color: context.onPrimaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  message,
                  if (content != null) content,
                ],
              ),
            ),
            actions: actions,
          );
        } else {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyleApp.bold16().copyWith(
                color: context.onPrimaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  message,
                  if (content != null) content,
                ],
              ),
            ),
            actions: actions,
          );
        }
      },
    );
  }

  /// Helper method to create a dialog action button.
  static Widget _buildDialogAction(
    BuildContext context, {
    required String text,
    required VoidCallback onPressed,
    bool isDefaultAction = false,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoDialogAction(
        onPressed: onPressed,
        isDefaultAction: isDefaultAction,
        child: Text(
          text,
          style: TextStyleApp.bold14().copyWith(
            color: context.primaryColor,
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyleApp.bold14().copyWith(
            color: context.primaryColor,
          ),
        ),
      );
    }
  }
}


//* Usage:

/* 
await AdaptiveDialogs.showOkAlertDialog(
  context: context,
  title: "Success",
  message: "Your operation was successful!",
);
*/


/*
bool? result = await AdaptiveDialogs.showOkCancelAlertDialog(
  context: context,
  title: "Confirm",
  message: "Do you want to proceed?",
);
if (result == true) {
  print("User pressed OK");
} else {
  print("User pressed Cancel");
}
*/


/*
bool? isConfirmed = await AdaptiveDialogs.showConfirmationDialog(
  context: context,
  title: "Delete Item",
  message: "Are you sure you want to delete this?",
  confirmText: "Delete",
  cancelText: "Cancel",
);
if (isConfirmed == true) {
  print("Item deleted");
} else {
  print("Action canceled");
}
*/


/*
await AdaptiveDialogs.showModalActionSheet(
  context: context,
  title: "Choose an option",
  actions: ["Option 1", "Option 2", "Option 3"],
  onSelected: (index) {
    print("Selected option: ${index + 1}");
  },
);
*/

/*
String? userInput = await AdaptiveDialogs.showTextInputDialog(
  context: context,
  title: "Enter your name",
  hintText: "Type here...",
  confirmText: "Submit",
);
if (userInput != null) {
  print("User entered: $userInput");
}
*/
