import 'package:firebase_database/firebase_database.dart';

class RoomRepositoryService {
  Future<void> createRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).set({
      'createdAt': ServerValue.timestamp,
      'status': 'waiting',
    });
  }

  Future<void> updateRoomStatus(String roomID, String status) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).update({'status': status});
  }

  Future<void> deleteRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).remove();
  }

  Future<void> addPlayer(
      String roomID, String playerName, String playerID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref
        .child(roomID)
        .child('player')
        .child(playerID)
        .set({'name': playerName});
  }

  Future<void> removePlayer(String roomID, String playerID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).child('player').child(playerID).remove();
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

  Future<void> addHomework(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).child('homework').set({
      'startTime': ServerValue.timestamp,
    });
  }

  Future<void> addResult(
      String roomID, String playerID, String playerName) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref
        .child(roomID)
        .child('homework')
        .child('result')
        .child(playerID)
        .set({
      'clearTime': ServerValue.timestamp,
      'playerName': playerName,
    });
  }

  Future<void> removeResult(String roomID, String playerID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref
        .child(roomID)
        .child('homework')
        .child('result')
        .child(playerID)
        .remove();
  }
}
