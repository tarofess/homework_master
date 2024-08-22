// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      createdAt: (json['createdAt'] as num).toInt(),
      players: Map<String, String>.from(json['players'] as Map),
      homework: json['homework'] == null
          ? null
          : Homework.fromJson(json['homework'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'players': instance.players,
      'homework': instance.homework,
    };
