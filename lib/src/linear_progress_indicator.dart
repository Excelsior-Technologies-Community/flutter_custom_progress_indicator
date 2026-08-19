import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double progress;
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? gradient;
  final BorderRadius borderRadius;
  final Duration animationDuration;
  final bool showPercentage;
  final TextStyle? percentageTextStyle;

  const CustomLinearProgressIndicator({
    super.key,
    required this.progress,
    this.height = 12,
    this.width,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
    this.gradient,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
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
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: height,
              color: backgroundColor,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _value),
                duration: animationDuration,
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return FractionallySizedBox(
                    widthFactor: value,
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
            if (showPercentage)
              Text(
                '${(_value * 100).round()}%',
                style:
                    percentageTextStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
