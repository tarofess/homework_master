import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/model/player.dart';
import 'package:homework_master/model/room.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final waitingPlayersProvider =
    StreamProvider.family<List<Player>?, String>((ref, roomID) {
  final ref = FirebaseDatabase.instance.ref('room/$roomID');
  return ref.onValue.map((event) {
    if (event.snapshot.value == null) {
      return null;
    }

    final data = event.snapshot.value as Map<Object?, Object?>?;
    final Map<String, dynamic> jsonData = data!.map(
      (key, value) => MapEntry(key.toString(), value),
    );

    final room = Room.fromJson(jsonData);
    return room.players.entries
        .map((entry) => Player(id: entry.key, name: entry.value))
        .toList();
  });
});
