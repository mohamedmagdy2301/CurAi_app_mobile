import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    this.isLoading = false,
    super.key,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: onPressed,
      child: isLoading
          ? const CustomLoadingWidget(
              width: 30,
              height: 30,
            )
          : Text(
              context.translate(title),
              style: TextStyleApp.bold24().copyWith(
                color: Colors.white,
              ),
            ),
    );
  }
}
