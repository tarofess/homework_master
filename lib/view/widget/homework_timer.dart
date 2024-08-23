// homework_timer.dart
import 'package:flutter/material.dart';
import 'package:homework_master/viewmodel/provider/homework_timer_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkTimer extends HookConsumerWidget {
  const HomeworkTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final timerValue = ref.watch(homeworkTimerProvider);
    final timerNotifier = ref.read(homeworkTimerProvider.notifier);

    return Text(
      timerNotifier.formatTime(),
      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    );
  }
}
