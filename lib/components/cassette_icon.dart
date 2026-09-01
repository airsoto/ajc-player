import 'package:flutter/material.dart';

class CassetteIcon extends StatelessWidget {
  const CassetteIcon({
    super.key,
    this.size = 42,
    this.color = Colors.white,
    this.backgroundColor = const Color(0xFF252525),
  });

  final double size;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _CassettePainter(
          color: color,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}

class _CassettePainter extends CustomPainter {
  const _CassettePainter({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 48;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * scale;
    final fill = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 7 * scale, 42 * scale, 34 * scale),
      Radius.circular(5 * scale),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    final window = RRect.fromRectAndRadius(
      Rect.fromLTWH(9 * scale, 13 * scale, 30 * scale, 13 * scale),
      Radius.circular(3 * scale),
    );
    canvas.drawRRect(window, stroke);
    canvas.drawCircle(Offset(16 * scale, 19.5 * scale), 4 * scale, stroke);
    canvas.drawCircle(Offset(32 * scale, 19.5 * scale), 4 * scale, stroke);
    canvas.drawLine(
      Offset(20 * scale, 19.5 * scale),
      Offset(28 * scale, 19.5 * scale),
      stroke,
    );

    final lower = Path()
      ..moveTo(13 * scale, 31 * scale)
      ..lineTo(35 * scale, 31 * scale)
      ..lineTo(39 * scale, 38 * scale)
      ..lineTo(9 * scale, 38 * scale)
      ..close();
    canvas.drawPath(lower, stroke);
    canvas.drawCircle(Offset(17 * scale, 35 * scale), 1.5 * scale, stroke);
    canvas.drawCircle(Offset(31 * scale, 35 * scale), 1.5 * scale, stroke);
  }

  @override
  bool shouldRepaint(covariant _CassettePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
