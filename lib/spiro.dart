import 'package:flutter/material.dart';
import 'dart:math';

class Spiro extends StatelessWidget {
  final AnimationController controller;
  const Spiro({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
          aspectRatio: 1.0,
          child: CustomPaint(
            painter: PaintSpiro(controller: controller),
          )),
    ));
  }
}

class PaintSpiro extends CustomPainter {
  final double ratio;
  final AnimationController controller;
  double get angle => controller.value;

  final path = Path();
  static const lineWidth = 2.0;
  static final p = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = lineWidth;

  PaintSpiro({required this.controller, this.ratio = 1 / 3})
      : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2 - lineWidth;
    path.lineTo(radius * cos(angle), radius * sin(angle));
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
