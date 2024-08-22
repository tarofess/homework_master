import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationViewModel {
  final sharedPreferencesService = getIt<SharedPreferencesService>();
  final roomRepositoryService = getIt<RoomRepositoryService>();

  Future<String> requestMakeRoom() async {
    String roomID;
    do {
      roomID = generateRoomID();
    } while (await roomRepositoryService.isExistRoomID(roomID));

    await roomRepositoryService.createRoom(roomID);
    final username = await sharedPreferencesService.getUsername();
    final userID = await roomRepositoryService.addPlayer(roomID, username!);
    await sharedPreferencesService.saveUserID(userID.key!);
    return roomID;
  }

  Future<bool> requestEnterRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('room').orderByKey().equalTo(roomID).get();

    if (snapshot.exists) {
      final username = await sharedPreferencesService.getUsername();
      final userID = await roomRepositoryService.addPlayer(roomID, username!);
      await sharedPreferencesService.saveUserID(userID.key!);
      return true;
    } else {
      return false;
    }
  }

  String generateRoomID() {
    const String chars = '123456789abcdefghijklmnopqrstuvwxyz';
    Random random = Random();

    return List.generate(4, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}

final roomPreparationViewModelProvider =
    Provider((ref) => RoomPreparationViewModel());
