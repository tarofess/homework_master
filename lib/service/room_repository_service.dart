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

  Future<void> addPlayer(String roomID, String username, String userID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref
        .child(roomID)
        .child('player')
        .child(userID)
        .set({'name': username});
  }

  Future<void> removePlayer(String roomID, String userID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).child('player').child(userID).remove();
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

  Future<void> addResult(String roomID, String userID, String username) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref
        .child(roomID)
        .child('homework')
        .child('result')
        .child(userID)
        .set({
      'clearTime': ServerValue.timestamp,
      'username': username,
    });
  }

  Future<void> removeResult(String roomID, String userID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref
        .child(roomID)
        .child('homework')
        .child('result')
        .child(userID)
        .remove();
  }
}
