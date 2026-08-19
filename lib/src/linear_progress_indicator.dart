import 'package:flutter/material.dart';

/// A customizable, animated linear progress indicator component.
///
/// Features:
/// - Smooth progress animation driven by [animationDuration] and [animationCurve].
/// - Solid color or custom [gradient] fill.
/// - Percentage / text overlay with custom [valueFormatter] or center [child] widget.
/// - Adjustable height, width, background color, and rounded corners ([borderRadius]).
class CustomLinearProgressIndicator extends StatelessWidget {
  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// Height of the progress bar.
  final double height;

  /// Optional width of the progress bar. If null, takes available width.
  final double? width;

  /// Background track color.
  final Color backgroundColor;

  /// Progress bar color (used when [gradient] is null).
  final Color progressColor;

  /// Optional gradient for the filled progress bar.
  final Gradient? gradient;

  /// Border radius for rounded bar edges.
  final BorderRadius borderRadius;

  /// Duration of the progress change animation.
  final Duration animationDuration;

  /// Animation curve for progress changes.
  final Curve animationCurve;

  /// Whether to display percentage text centered over the progress bar.
  final bool showPercentage;

  /// Style for the percentage text overlay.
  final TextStyle? percentageTextStyle;

  /// Optional custom text formatter function for the animated progress value.
  final String Function(double progress)? valueFormatter;

  /// Optional custom widget to overlay in the center of the progress bar.
  final Widget? child;

  const CustomLinearProgressIndicator({
    super.key,
    required this.progress,
    this.height = 16,
    this.width,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
    this.gradient,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
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
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Track background
            Container(
              width: double.infinity,
              height: height,
              color: backgroundColor,
            ),

            // Animated progress fill bar
            Align(
              alignment: Alignment.centerLeft,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _clampedProgress),
                duration: animationDuration,
                curve: animationCurve,
                builder: (context, animatedValue, _) {
                  return FractionallySizedBox(
                    widthFactor: animatedValue,
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: gradient == null ? progressColor : null,
                        gradient: gradient,
                        borderRadius: borderRadius,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Text / Widget Overlay
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: _clampedProgress),
              duration: animationDuration,
              curve: animationCurve,
              builder: (context, animatedValue, _) {
                if (child != null) {
                  return child!;
                }

                if (showPercentage) {
                  final displayText = valueFormatter != null
                      ? valueFormatter!(animatedValue)
                      : '${(animatedValue * 100).round()}%';

                  return Text(
                    displayText,
                    style: percentageTextStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
