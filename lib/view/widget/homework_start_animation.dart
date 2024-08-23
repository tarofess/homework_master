import 'package:flutter/material.dart';

class HomeworkStartAnimation extends StatelessWidget {
  final String text;

  const HomeworkStartAnimation({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double opacity, Widget? child) {
        return Opacity(
          opacity: opacity,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
