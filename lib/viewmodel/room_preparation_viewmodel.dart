import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationViewModel {
  final sharedPreferencesService = getIt<SharedPreferencesService>();

  Future<String> requestMakeRoom() async {
    String roomID;
    do {
      roomID = generateRoomID();
    } while (await isExistRoomID(roomID));

    final username = await sharedPreferencesService.getUsername();
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).child('players').push().set(username);
    return roomID;
  }

  Future<bool> requestEnterRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('room').orderByKey().equalTo(roomID).get();

    if (snapshot.exists) {
      final username = await sharedPreferencesService.getUsername();
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref.child(roomID).child('players').push().set(username);
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

  Future<bool> isExistRoomID(String roomID) async {
    final ref = FirebaseDatabase.instance.ref('room/$roomID');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}

final roomPreparationViewModelProvider =
    Provider((ref) => RoomPreparationViewModel());
