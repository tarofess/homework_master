import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homework_master/model/homework.dart';
import 'package:homework_master/model/player.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required int createdAt,
    required String status,
    required Map<String, Player> player,
    required Homework? homework,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

extension RoomExtension on Room {
  List<MapEntry<String, Player>> get playersList => player.entries.toList();
}
