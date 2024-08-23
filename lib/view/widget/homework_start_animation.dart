import 'package:flutter/material.dart';

class HomeworkStartAnimation extends StatelessWidget {
  final String text;
  final double fontSize;
  final int duration;

  const HomeworkStartAnimation({
    super.key,
    required this.text,
    required this.fontSize,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(seconds: duration),
      builder: (BuildContext context, double opacity, Widget? child) {
        return SafeArea(
          child: Opacity(
            opacity: opacity,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
