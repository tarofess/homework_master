import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homework_master/model/homework.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required int createdAt,
    required Map<String, String> players,
    required Homework? homework,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
