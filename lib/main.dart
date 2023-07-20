import 'package:flutter/material.dart';
import 'dart:math';
import 'spiro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spirograph',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpiroPage(title: 'Spirograph'),
    );
  }
}

class SpiroPage extends StatefulWidget {
  const SpiroPage({super.key, required this.title});

  final String title;

  @override
  State<SpiroPage> createState() => _SpiroPageState();
}

class _SpiroPageState extends State<SpiroPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  double ratio = 1.0 / 5; //initial ratio
  static const duration = 10; //seconds

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: duration),
      upperBound: 2 * pi,
    )..addStatusListener((status) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Spiro(controller: controller),
      bottomNavigationBar: const BottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: !controller.isAnimating
          ? FloatingActionButton(
              onPressed: () => controller.forward(from: controller.lowerBound),
              tooltip: 'Start Animation',
              child: const Icon(Icons.play_arrow),
            )
          : FloatingActionButton(
              onPressed: controller.reset,
              tooltip: 'Stop Animation',
              child: const Icon(Icons.stop),
            ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
