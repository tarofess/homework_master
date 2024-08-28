import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class RoomRepositoryService {
  Future<void> createRoom(String roomID) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref.child(roomID).set({
        'createdAt': ServerValue.timestamp,
        'status': 'waiting',
      }).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRoomStatus(String roomID, String status) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref
          .child(roomID)
          .update({'status': status}).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRoom(String roomID) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref.child(roomID).remove().timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPlayer(
      String roomID, String playerName, String playerID) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref
          .child(roomID)
          .child('player')
          .child(playerID)
          .set({'name': playerName}).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removePlayer(String roomID, String playerID) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref
          .child(roomID)
          .child('player')
          .child(playerID)
          .remove()
          .timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isExistRoomID(String roomID) async {
    try {
      final ref = FirebaseDatabase.instance.ref('room/$roomID');
      final snapshot = await ref.get().timeout(const Duration(seconds: 10));
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addHomework(String roomID) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref.child(roomID).child('homework').set({
        'startTime': ServerValue.timestamp,
      }).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addResult(
      String roomID, String playerID, String playerName) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref
          .child(roomID)
          .child('homework')
          .child('result')
          .child(playerID)
          .set({
        'clearTime': ServerValue.timestamp,
        'playerName': playerName,
      }).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeResult(String roomID, String playerID) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
      await ref
          .child(roomID)
          .child('homework')
          .child('result')
          .child(playerID)
          .remove()
          .timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      throw Exception('操作がタイムアウトしました\nもう一度お試しください');
    } catch (e) {
      rethrow;
    }
  }
}
