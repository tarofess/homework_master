import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class RoomPreparationViewModel {
  final sharedPreferencesService = getIt<SharedPreferencesService>();
  final roomRepositoryService = getIt<RoomRepositoryService>();

  Future<String> requestMakeRoom() async {
    String roomID;
    do {
      roomID = generateRoomID();
    } while (await roomRepositoryService.isExistRoomID(roomID));

    await roomRepositoryService.createRoom(roomID);
    await addPlayerToRoom(roomID);
    return roomID;
  }

  Future<bool> requestEnterRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('room').orderByKey().equalTo(roomID).get();

    if (snapshot.exists) {
      await addPlayerToRoom(roomID);
      return true;
    } else {
      return false;
    }
  }

  Future<void> addPlayerToRoom(String roomID) async {
    final playerName = await sharedPreferencesService.getPlayerName();
    final playerID = const Uuid().v4();
    await roomRepositoryService.addPlayer(roomID, playerName!, playerID);
    await sharedPreferencesService.savePlayerID(playerID);
  }

  String generateRoomID() {
    const String chars = '123456789abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(4, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  bool isRoomIdExists(String? roomID) {
    return roomID != null && roomID.isNotEmpty ? true : false;
  }

  bool isRoomIdNotFound(String? roomID) {
    return roomID != null && roomID.isEmpty ? true : false;
  }
}

final roomPreparationViewModelProvider =
    Provider((ref) => RoomPreparationViewModel());
