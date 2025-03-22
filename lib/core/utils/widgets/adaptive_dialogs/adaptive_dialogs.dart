// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDialogs {
  /// Show an alert
  static Future<void> shoLoadingAlertDialog({
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
  static Future<void> showOkAlertDialog({
    required BuildContext context,
    required String title,
    required Widget message,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: message,
      actions: [
        _buildDialogAction(
          context,
          text: context.translate(LangKeys.ok),
          onPressed: () {},
        ),
      ],
    );
  }

  /// Show an alert with "OK" and "Cancel" buttons.
  static Future<bool?> showOkCancelAlertDialog({
    required BuildContext context,
    required String title,
    required Widget message,
    void Function()? onPressedOk,
    void Function()? onPressedCancel,
  }) async {
    return _showPlatformDialog(
      context: context,
      title: title,
      message: message,
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
      await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(title),
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
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              ...actions.asMap().entries.map((entry) {
                return ListTile(
                  title: Text(entry.value),
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

    await _showPlatformDialog(
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
            title: Text(title),
            content: Column(
              children: [
                message,
                if (content != null) content,
              ],
            ),
            actions: actions,
          );
        } else {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                message,
                if (content != null) content,
              ],
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
        child: Text(text),
      );
    } else {
      return TextButton(onPressed: onPressed, child: Text(text));
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