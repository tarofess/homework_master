import 'dart:async';

import 'package:flutter/material.dart';

class HomeworkTimer extends StatefulWidget {
  const HomeworkTimer({super.key});

  @override
  HomeworkTimerState createState() => HomeworkTimerState();
}

class HomeworkTimerState extends State<HomeworkTimer> {
  int _milliseconds = 0;
  late Timer _timer;
  bool _isRunning = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds += 10;
      });
    });
    _isRunning = true;
  }

  void _stopTimer() {
    _timer.cancel();
    _isRunning = false;
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).floor() % 100;
    int seconds = (milliseconds / 1000).floor() % 60;
    int minutes = (milliseconds / 60000).floor() % 60;
    int hours = (milliseconds / 3600000).floor();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr.$hundredsStr';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_milliseconds),
      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    );
  }
}
