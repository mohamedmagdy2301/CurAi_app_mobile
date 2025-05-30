import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedSnackBar extends StatefulWidget {
  const AnimatedSnackBar({
    required this.message,
    required this.backgroundColor,
    required this.snackBarTheme,
    super.key,
    this.isIconVisible,
    this.icon,
    this.labelAction,
    this.onPressedAction,
    this.showCloseIcon,
  });

  final String message;
  final Color backgroundColor;
  final bool? isIconVisible;
  final IconData? icon;
  final String? labelAction;
  final VoidCallback? onPressedAction;
  final SnackBarThemeData snackBarTheme;
  final bool? showCloseIcon; // ← جديد

  @override
  State<AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(8.r),
          color: widget.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isIconVisible ?? false)
                  Icon(
                    widget.icon,
                    color: widget.snackBarTheme.contentTextStyle?.color,
                    size: 20.sp,
                  ).paddingTop(3),
                if (widget.isIconVisible ?? false) 8.wSpace,
                AutoSizeText(
                  widget.message,
                  style: widget.snackBarTheme.contentTextStyle,
                ).expand(),
                if (widget.labelAction != null)
                  TextButton(
                    onPressed: widget.onPressedAction,
                    child: Text(
                      widget.labelAction!,
                      style: TextStyleApp.bold14().copyWith(
                        color: widget.snackBarTheme.actionTextColor,
                      ),
                    ),
                  ),
                if (widget.showCloseIcon ?? false)
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.clear,
                      color: widget.snackBarTheme.contentTextStyle?.color,
                      size: 20.sp,
                    ),
                    onPressed: () => hideMessage(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
