// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// Widget for Animated SnackBar
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
  });

  final String message;
  final Color backgroundColor;
  final bool? isIconVisible;
  final IconData? icon;
  final String? labelAction;
  final VoidCallback? onPressedAction;
  final SnackBarThemeData snackBarTheme;

  @override
  _AnimatedSnackBarState createState() => _AnimatedSnackBarState();
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
      duration: const Duration(milliseconds: 700), // Smooth duration
    );

    // Slide animation (bottom-to-top)
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start below the screen
      end: Offset.zero, // Slide into view
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    // Fade-in effect
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start the animation
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
          borderRadius: BorderRadius.circular(8),
          color: widget.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                if (widget.isIconVisible ?? false)
                  Icon(
                    widget.icon,
                    color: widget.snackBarTheme.contentTextStyle?.color,
                    size: 20,
                  ),
                if (widget.isIconVisible ?? false) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.message,
                    style: widget.snackBarTheme.contentTextStyle,
                  ),
                ),
                if (widget.labelAction != null)
                  TextButton(
                    onPressed: widget.onPressedAction,
                    child: Text(
                      widget.labelAction!,
                      style: TextStyle(
                        color: widget.snackBarTheme.actionTextColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}