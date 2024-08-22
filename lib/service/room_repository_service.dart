import 'package:firebase_database/firebase_database.dart';

class RoomRepositoryService {
  Future<void> createRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).set({
      'created_at': ServerValue.timestamp,
    });
  }

  Future<void> deleteRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).remove();
  }

  Future<DatabaseReference> addPlayer(String roomID, String username) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    final userID = ref.child(roomID).child('players').push();
    await userID.set(username);
    return userID;
  }

  Future<void> removePlayer(String roomID, String userID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).child('players').child(userID).remove();
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
