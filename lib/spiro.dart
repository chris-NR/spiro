import 'package:flutter/material.dart';
import 'dart:math';

class Spiro extends StatelessWidget {
  final AnimationController controller;
  final Path path;
  const Spiro({super.key, required this.controller, required this.path});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
          aspectRatio: 1.0,
          child: CustomPaint(
            painter: PaintSpiro(controller: controller, path: path),
          )),
    ));
  }
}

//Hello comment

class PaintSpiro extends CustomPainter {
  final double radiusRatio;
  final double locusRatio;
  final AnimationController controller;
  final Path path;
  double get angle => controller.value;

  static const lineWidth = 2.0;
  static final p = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = lineWidth;

  PaintSpiro(
      {required this.controller,
      required this.path,
      this.radiusRatio = 1 / 3.5,
      this.locusRatio = 1 / 5});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2 - lineWidth;

    if (angle == 0.0) {
      path.reset();
      final p = point(
          radius: radius,
          radiusRatio: radiusRatio,
          locusRatio: locusRatio,
          angle: angle);
      path.moveTo(p.x, p.y);
    } else {
      final p = point(
          radius: radius,
          radiusRatio: radiusRatio,
          locusRatio: locusRatio,
          angle: angle);
      path.lineTo(p.x, p.y);
    }
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawPath(path, p);
  }

  Point<double> point(
      {required double radius,
      required double radiusRatio,
      required double locusRatio,
      required double angle}) {
    final minorRadius = radius * radiusRatio;
    final locus = minorRadius * locusRatio;
    final RminusR = radius - minorRadius;
    final rho = locus;
    final x = RminusR * cos(angle) + rho * cos((RminusR / minorRadius) * angle);
    final y = RminusR * sin(angle) - rho * sin((RminusR / minorRadius) * angle);
    return Point(x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
//x = (R-r)*cos(t) + rho*cos(((R-r)/r)*t),
//y = (R-r)*sin(t) - rho*sin(((R-r)/r)*t),