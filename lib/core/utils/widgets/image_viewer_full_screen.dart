// ignore_for_file: lines_longer_than_80_chars, deprecated_member_use

import 'dart:ui';

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showImageViewerFullScreen(
  BuildContext context, {
  required String imageUrl,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'image_viewer',
    barrierColor: Colors.transparent,
    pageBuilder: (context, animation, secondaryAnimation) {
      return _ImageViewerDialog(imageUrl: imageUrl);
    },
  );
}

class _ImageViewerDialog extends StatefulWidget {
  const _ImageViewerDialog({required this.imageUrl});
  final String imageUrl;

  @override
  State<_ImageViewerDialog> createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<_ImageViewerDialog> {
  double _dragOffset = 0;
  double _opacity = 1;

  double _scale = 1;
  Offset _position = Offset.zero;

  final TransformationController _transformationController =
      TransformationController();

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_scale > 1.0 || _position != Offset.zero) return;

    if (details.primaryDelta != null && details.primaryDelta! > 0) {
      setState(() {
        _dragOffset += details.primaryDelta!;
        _opacity = (1 - (_dragOffset / 300)).clamp(0.0, 1.0);
      });
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_scale > 1.0 || _position != Offset.zero) return;

    if (_dragOffset > 100) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _dragOffset = 0.0;
        _opacity = 1.0;
      });
    }
  }

  void _handleDoubleTap(TapDownDetails details) {
    final position = details.localPosition;

    if (_scale > 1.0) {
      _transformationController.value = Matrix4.identity();
      _scale = 1.0;
    } else {
      const zoomScale = 1.5;
      _transformationController.value = Matrix4.identity()
        ..translate(
          -position.dx * (zoomScale - 1),
          -position.dy * (zoomScale - 1),
        )
        ..scale(zoomScale);
      _scale = zoomScale;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        onDoubleTapDown: _handleDoubleTap,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: Colors.black.withOpacity(0.6 * _opacity),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _opacity,
              child: Transform.translate(
                offset: Offset(0, _dragOffset),
                child: Center(
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    onInteractionUpdate: (details) {
                      setState(() {
                        _scale = details.scale;
                        _position = details.focalPointDelta;
                      });
                    },
                    onInteractionEnd: (_) {
                      setState(() {
                        _position = Offset.zero;
                      });
                    },
                    child: CustomCachedNetworkImage(
                      imgUrl: widget.imageUrl,
                      width: context.H * 0.4,
                      height: context.H * 0.5,
                      loadingImgPadding: 60.sp,
                      errorIconSize: 60.sp,
                    ),
                  ).cornerRadiusWithClipRRect(12.r),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(30.r),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 35.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
