import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkViewModel {
  Future<void> finishedHomework() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

final homeworkViewModelProvider = Provider((ref) => HomeworkViewModel());
