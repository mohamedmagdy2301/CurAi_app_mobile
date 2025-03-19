import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    this.isLoading,
    super.key,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: onPressed,
      child: isLoading == false
          ? const CustomLoadingWidget()
          : Text(
              context.translate(title),
              style: context.styleRegular20.copyWith(color: Colors.white),
            ),
    );
  }
}
