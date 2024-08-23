import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkTimerNotifier extends StateNotifier<int> {
  HomeworkTimerNotifier() : super(0);
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      state += 10;
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    state = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatTime() {
    int hundreds = (state / 10).floor() % 100;
    int seconds = (state / 1000).floor() % 60;
    int minutes = (state / 60000).floor() % 60;
    int hours = (state / 3600000).floor();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr.$hundredsStr';
  }
}

final homeworkTimerProvider =
    StateNotifierProvider<HomeworkTimerNotifier, int>((ref) {
  return HomeworkTimerNotifier();
});
