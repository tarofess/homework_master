import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/model/players.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final waitingPlayersProvider =
    StreamProvider.family<List<Players>, String>((ref, roomID) {
  final databaseRef = FirebaseDatabase.instance.ref('room/$roomID/players');
  return databaseRef.onValue.map((event) {
    final data = event.snapshot.value as Map<Object?, Object?>?;
    if (data == null) {
      return [];
    }

    return data.entries.map((entry) {
      final playerID = entry.key as String;
      final playerName = entry.value as String;
      return Players(id: playerID, name: playerName);
    }).toList();
  });
});
