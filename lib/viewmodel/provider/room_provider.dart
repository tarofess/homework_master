import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/model/room.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final roomProvider = StreamProvider.family<Room?, String>((ref, roomID) {
  final ref = FirebaseDatabase.instance.ref('room/$roomID');
  return ref.onValue.map((event) {
    if (event.snapshot.value == null) {
      return null;
    }

    final data = event.snapshot.value as Map<Object?, Object?>?;
    final json = preprocessJson(data!);
    final room = Room.fromJson(json);
    return room;
  });
});

Map<String, dynamic> preprocessJson(Map<dynamic, dynamic> input) {
  return input.map((key, value) {
    if (value is Map) {
      return MapEntry(key.toString(), preprocessJson(value));
    } else if (value is List) {
      return MapEntry(key.toString(),
          value.map((e) => e is Map ? preprocessJson(e) : e).toList());
    } else {
      return MapEntry(key.toString(), value);
    }
  });
}
