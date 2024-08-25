// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      createdAt: (json['createdAt'] as num).toInt(),
      status: json['status'] as String,
      player: (json['player'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Player.fromJson(e as Map<String, dynamic>)),
      ),
      homework: json['homework'] == null
          ? null
          : Homework.fromJson(json['homework'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'status': instance.status,
      'player': instance.player,
      'homework': instance.homework,
    };
