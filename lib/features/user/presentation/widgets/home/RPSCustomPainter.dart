import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter({required this.context});

  final BuildContext context;
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    final paintFill0 = Paint()
      ..color = context.primaryColor.withAlpha(150)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final path_0 = Path()
      ..moveTo(size.width * 0.5440000, -2)
      ..lineTo(size.width * 1.0570000, -2)
      ..lineTo(size.width * 0.5700000, size.height * 1.162857)
      ..lineTo(size.width * 0.2300000, size.height * 0.9600000)
      ..lineTo(size.width * 0.5440000, size.height * 0.1945714)
      ..close();

    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
