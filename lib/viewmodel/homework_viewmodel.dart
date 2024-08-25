import 'package:homework_master/main.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkViewModel {
  final roomRepositoryService = getIt<RoomRepositoryService>();
  final sharedPreferencesService = getIt<SharedPreferencesService>();

  Future<void> finishedHomework(String roomID) async {
    final userID = await sharedPreferencesService.getUserID();
    roomRepositoryService.addResult(roomID, userID!);
  }

  Future<void> undoHomework(String roomID) async {
    final userID = await sharedPreferencesService.getUserID();
    roomRepositoryService.removeResult(roomID, userID!);
  }
}

final homeworkViewModelProvider = Provider((ref) => HomeworkViewModel());
