import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A highly customizable, animated circular progress indicator widget.
///
/// Features:
/// - CustomPainter implementation supporting solid colors & gradients (`SweepGradient`, `LinearGradient`, etc.).
/// - Custom stroke caps ([StrokeCap.round], [StrokeCap.butt]).
/// - Animated progress with [animationDuration] and [animationCurve].
/// - Animated percentage text overlay with custom [valueFormatter].
/// - Optional central [child] widget overlay (icons, widgets, badges).
class CustomCircularProgressIndicator extends StatelessWidget {
  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// Width and height of the circular container.
  final double size;

  /// Thickness of the progress arc stroke.
  final double strokeWidth;

  /// Background track color.
  final Color backgroundColor;

  /// Progress arc color (used when [gradient] is null).
  final Color progressColor;

  /// Optional gradient for the progress arc.
  final Gradient? gradient;

  /// Shape of the stroke ends ([StrokeCap.round] or [StrokeCap.butt]).
  final StrokeCap strokeCap;

  /// Duration of progress change animation.
  final Duration animationDuration;

  /// Animation curve for progress changes.
  final Curve animationCurve;

  /// Whether to display percentage text overlay in the center.
  final bool showPercentage;

  /// Custom text style for the percentage overlay.
  final TextStyle? percentageTextStyle;

  /// Optional custom text formatter function for the animated progress value.
  final String Function(double progress)? valueFormatter;

  /// Optional custom widget overlay placed in the center of the circle.
  final Widget? child;

  const CustomCircularProgressIndicator({
    super.key,
    required this.progress,
    this.size = 100,
    this.strokeWidth = 10,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
    this.gradient,
    this.strokeCap = StrokeCap.round,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.showPercentage = false,
    this.percentageTextStyle,
    this.valueFormatter,
    this.child,
  });

  double get _clampedProgress => progress.clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: _clampedProgress),
        duration: animationDuration,
        curve: animationCurve,
        builder: (context, animatedValue, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _CircularProgressPainter(
                  progress: animatedValue,
                  strokeWidth: strokeWidth,
                  backgroundColor: backgroundColor,
                  progressColor: progressColor,
                  gradient: gradient,
                  strokeCap: strokeCap,
                ),
              ),
              if (child != null)
                child!
              else if (showPercentage)
                Text(
                  valueFormatter != null
                      ? valueFormatter!(animatedValue)
                      : '${(animatedValue * 100).round()}%',
                  style: percentageTextStyle ??
                      TextStyle(
                        fontSize: size * 0.2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? gradient;
  final StrokeCap strokeCap;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    this.gradient,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Draw track background
    final trackPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Draw progress arc
    final progressPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    if (gradient != null) {
      progressPaint.shader = gradient!.createShader(rect);
    } else {
      progressPaint.color = progressColor;
    }

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.gradient != gradient ||
        oldDelegate.strokeCap != strokeCap;
  }
}
