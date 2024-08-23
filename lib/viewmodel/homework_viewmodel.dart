import 'package:homework_master/service/room_repository_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkViewModel {
  final roomRepositoryService = RoomRepositoryService();

  Future<void> finishedHomework() async {
    // cleartimeの保存処理
  }
}

final homeworkViewModelProvider = Provider((ref) => HomeworkViewModel());
