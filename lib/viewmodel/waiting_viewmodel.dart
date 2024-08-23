import 'package:homework_master/main.dart';
import 'package:homework_master/model/room.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingViewModel {
  final sharedPreferencesService = getIt<SharedPreferencesService>();
  final roomRepositoryService = getIt<RoomRepositoryService>();

  Future<void> closeRoom(String roomID) async {
    await roomRepositoryService.deleteRoom(roomID);
  }

  Future<void> leaveRoom(String roomID) async {
    final userID = await sharedPreferencesService.getUserID();
    if (userID == null) return;

    await roomRepositoryService.removePlayer(roomID, userID);
  }

  bool isRoomStateReady(Room? room) {
    return room != null && room.status == 'ready' ? true : false;
  }
}

final waitingViewModelProvider = Provider((ref) => WaitingViewModel());
