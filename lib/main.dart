import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpiroPage(title: 'Flutter Demo Home Page'),
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
  double ratio = 1.0 / 3; //initial ratio
  static const duration = 60; //seconds

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: duration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(),
      ),
      floatingActionButton: !controller.isAnimating
          ? FloatingActionButton(
              onPressed: controller.forward,
              tooltip: 'Start Animation',
              child: const Icon(Icons.play_arrow),
            )
          : FloatingActionButton(
              onPressed: controller.stop,
              tooltip: 'Stop Animation',
              child: const Icon(Icons.stop),
            ),
    );
  }
}
