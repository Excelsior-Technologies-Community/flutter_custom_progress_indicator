import 'package:flutter/material.dart';
import 'package:flutter_custom_progress_indicator/flutter_custom_progress_indicator.dart';


void main() {
  runApp(const ProgressDemoApp());
}

class ProgressDemoApp extends StatelessWidget {
  const ProgressDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Progress Indicators',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ProgressDemoPage(),
    );
  }
}

class ProgressDemoPage extends StatelessWidget {
  const ProgressDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Indicators')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Linear Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            const CustomLinearProgressIndicator(
              progress: 0.75,
              height: 20,
              showPercentage: true,
            ),

            const SizedBox(height: 50),

            const Text(
              'Circular Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const CustomCircularProgressIndicator(
              progress: 0.65,
              size: 120,
              strokeWidth: 12,
              showPercentage: true,
            ),
          ],
        ),
      ),
    );
  }
}
