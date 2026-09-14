import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:flutter/material.dart';

class RouteLogo extends StatelessWidget {
  final double width;
  final double height;

  final Color color;

  const RouteLogo({
    super.key,
    this.width = 237,
    this.height = 71,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _RouteLogoPainter(color: color),
    );
  }
}

class _RouteLogoPainter extends CustomPainter {
  final Color color;

  _RouteLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 237;
    final scaleY = size.height / 71;

    // Line from left leading into 'R'
    final pathR = Path()
      ..moveTo(0 * scaleX, 35 * scaleY)
      ..lineTo(35 * scaleX, 35 * scaleY)
      ..lineTo(35 * scaleX, 70 * scaleY)
      ..moveTo(35 * scaleX, 35 * scaleY)
      ..cubicTo(35 * scaleX, 10 * scaleY, 70 * scaleX, 10 * scaleY, 70 * scaleX, 35 * scaleY)
      ..cubicTo(70 * scaleX, 50 * scaleY, 50 * scaleX, 50 * scaleY, 35 * scaleX, 50 * scaleY)
      ..moveTo(48 * scaleX, 48 * scaleY)
      ..lineTo(70 * scaleX, 70 * scaleY);

    // 'o'
    final pathO = Path()
      ..addOval(Rect.fromLTWH(80 * scaleX, 32 * scaleY, 32 * scaleX, 35 * scaleY));

    // 'u'
    final pathU = Path()
      ..moveTo(122 * scaleX, 32 * scaleY)
      ..lineTo(122 * scaleX, 55 * scaleY)
      ..cubicTo(122 * scaleX, 68 * scaleY, 146 * scaleX, 68 * scaleY, 146 * scaleX, 55 * scaleY)
      ..lineTo(146 * scaleX, 32 * scaleY);

    // 't'
    final pathT = Path()
      ..moveTo(160 * scaleX, 20 * scaleY)
      ..lineTo(160 * scaleX, 67 * scaleY)
      ..moveTo(152 * scaleX, 35 * scaleY)
      ..lineTo(172 * scaleX, 35 * scaleY);

    // 'e'
    final pathE = Path()
      ..moveTo(182 * scaleX, 50 * scaleY)
      ..lineTo(214 * scaleX, 50 * scaleY)
      ..cubicTo(214 * scaleX, 30 * scaleY, 182 * scaleX, 30 * scaleY, 182 * scaleX, 52 * scaleY)
      ..cubicTo(182 * scaleX, 68 * scaleY, 214 * scaleX, 68 * scaleY, 214 * scaleX, 60 * scaleY);

    canvas.drawPath(pathR, paint);
    canvas.drawPath(pathO, paint);
    canvas.drawPath(pathU, paint);
    canvas.drawPath(pathT, paint);
    canvas.drawPath(pathE, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
