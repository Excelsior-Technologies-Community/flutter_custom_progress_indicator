import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? gradient;
  final Duration animationDuration;
  final bool showPercentage;
  final TextStyle? percentageTextStyle;

  const CustomCircularProgressIndicator({
    super.key,
    required this.progress,
    this.size = 100,
    this.strokeWidth = 10,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
    this.gradient,
    this.animationDuration = const Duration(milliseconds: 500),
    this.showPercentage = false,
    this.percentageTextStyle,
  });

  double get _value {
    return progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: _value),
        duration: animationDuration,
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: 1,
                strokeWidth: strokeWidth,
                color: backgroundColor,
              ),
              CircularProgressIndicator(
                value: value,
                strokeWidth: strokeWidth,
                color: progressColor,
              ),
              if (showPercentage)
                Text(
                  '${(value * 100).round()}%',
                  style:
                      percentageTextStyle ??
                      const TextStyle(fontWeight: FontWeight.bold),
                ),
            ],
          );
        },
      ),
    );
  }
}
