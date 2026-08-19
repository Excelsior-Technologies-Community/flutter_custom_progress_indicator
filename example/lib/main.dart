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
      title: 'Custom Progress Indicators Showcase',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: const ProgressDemoPage(),
    );
  }
}

class ProgressDemoPage extends StatefulWidget {
  const ProgressDemoPage({super.key});

  @override
  State<ProgressDemoPage> createState() => _ProgressDemoPageState();
}

class _ProgressDemoPageState extends State<ProgressDemoPage> {
  double _progress = 0.65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Progress Indicators'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Interactive Slider Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Control Progress: ${(_progress * 100).round()}%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Slider(
                      value: _progress,
                      min: 0.0,
                      max: 1.0,
                      divisions: 100,
                      label: '${(_progress * 100).round()}%',
                      onChanged: (val) => setState(() => _progress = val),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => setState(() => _progress = 0.0),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => setState(() => _progress = 1.0),
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Complete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // SECTION 1: Linear Progress Indicators
            Text(
              'Linear Progress Indicators',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 12),

            // Standard Linear
            _buildSectionCard(
              title: 'Standard Animated Linear with Percentage Overlay',
              child: CustomLinearProgressIndicator(
                progress: _progress,
                height: 24,
                showPercentage: true,
                progressColor: Colors.deepPurple,
                backgroundColor: Colors.deepPurple.shade50,
              ),
            ),
            const SizedBox(height: 12),

            // Gradient Linear
            _buildSectionCard(
              title: 'Gradient Fill Linear Indicator',
              child: CustomLinearProgressIndicator(
                progress: _progress,
                height: 20,
                showPercentage: true,
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purpleAccent, Colors.pinkAccent],
                ),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 12),

            // Custom Text Formatter Linear
            _buildSectionCard(
              title: 'Custom Text Formatter Overlay',
              child: CustomLinearProgressIndicator(
                progress: _progress,
                height: 28,
                showPercentage: true,
                progressColor: Colors.teal,
                backgroundColor: Colors.teal.shade50,
                valueFormatter: (p) => 'Completed ${(p * 100).round()} of 100 tasks',
                percentageTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // SECTION 2: Circular Progress Indicators
            Text(
              'Circular Progress Indicators',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Standard Circular
                _buildCircularCard(
                  title: 'Standard & Percentage',
                  child: CustomCircularProgressIndicator(
                    progress: _progress,
                    size: 110,
                    strokeWidth: 12,
                    showPercentage: true,
                    progressColor: Colors.deepPurple,
                    backgroundColor: Colors.deepPurple.shade50,
                  ),
                ),

                // Gradient Circular
                _buildCircularCard(
                  title: 'Gradient Sweep',
                  child: CustomCircularProgressIndicator(
                    progress: _progress,
                    size: 110,
                    strokeWidth: 12,
                    showPercentage: true,
                    strokeCap: StrokeCap.round,
                    gradient: const SweepGradient(
                      colors: [Colors.cyan, Colors.blue, Colors.purple, Colors.pink],
                    ),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Center Child Widget Circular
            _buildSectionCard(
              title: 'Circular with Custom Center Widget Overlay',
              child: Center(
                child: CustomCircularProgressIndicator(
                  progress: _progress,
                  size: 130,
                  strokeWidth: 14,
                  strokeCap: StrokeCap.round,
                  gradient: const LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                  ),
                  backgroundColor: Colors.orange.shade50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _progress >= 1.0 ? Icons.cloud_done : Icons.cloud_download,
                        color: Colors.deepOrange,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(_progress * 100).round()}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildCircularCard({required String title, required Widget child}) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
