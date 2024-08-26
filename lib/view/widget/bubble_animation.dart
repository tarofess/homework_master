import 'dart:math';
import 'package:flutter/material.dart';

class BubbleAnimation extends StatefulWidget {
  const BubbleAnimation({super.key});

  @override
  BubbleAnimationState createState() => BubbleAnimationState();
}

class BubbleAnimationState extends State<BubbleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Bubble> bubbles = [];
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeBubbles() {
    bubbles.clear();
    for (int i = 0; i < 50; i++) {
      bubbles.add(Bubble(screenSize));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenSize = Size(constraints.maxWidth, constraints.maxHeight);
        if (bubbles.isEmpty) {
          _initializeBubbles();
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: BubblePainter(bubbles, _controller.value, screenSize),
              size: Size.infinite,
            );
          },
        );
      },
    );
  }
}

class Bubble {
  late double x, y, size, speed;
  late Color color;

  Bubble(Size screenSize) {
    Random random = Random();
    x = random.nextDouble() * screenSize.width;
    y = random.nextDouble() * screenSize.height + screenSize.height; // 画面下部から開始
    size = random.nextDouble() * 20 + 5;
    speed = random.nextDouble() * 2 + 1;
    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      0.7,
    );
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final double animation;
  final Size screenSize;

  BubblePainter(this.bubbles, this.animation, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      double t = (animation - (bubble.y / screenSize.height)) % 1.0;
      double y = bubble.y - t * screenSize.height * bubble.speed;

      if (y < -50) {
        y += screenSize.height + 50;
      }

      final paint = Paint()
        ..color = bubble.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(bubble.x, y), bubble.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
