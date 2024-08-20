import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationViewModel {
  Future<String> requestMakeRoom() async {
    String roomNumber;
    do {
      roomNumber = generateRoomID();
    } while (await isExistRoomID(roomNumber));

    final DatabaseReference ref = FirebaseDatabase.instance.ref("room");
    await ref.push().set({'roomNumber': roomNumber});
    return roomNumber;
  }

  Future<bool> requestEnterRoom(String roomNumber) async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    final query =
        database.child('room').orderByChild('roomNumber').equalTo(roomNumber);
    final snapshot = await query.get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      data.forEach((roomId, roomData) {
        final typedRoomData = Map<String, dynamic>.from(roomData);
        final roomNumber = typedRoomData['roomNumber'];
      });
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
