import 'package:homework_master/service/room_repository_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkViewModel {
  final roomRepositoryService = RoomRepositoryService();

  Future<void> finishedHomework(String roomID) async {
    roomRepositoryService.addResult(roomID);
  }
}

final homeworkViewModelProvider = Provider((ref) => HomeworkViewModel());
