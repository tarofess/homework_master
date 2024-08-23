// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResultImpl _$$ResultImplFromJson(Map<String, dynamic> json) => _$ResultImpl(
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
      clearTime: (json['clearTime'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$$ResultImplToJson(_$ResultImpl instance) =>
    <String, dynamic>{
      'player': instance.player,
      'clearTime': instance.clearTime,
      'rank': instance.rank,
    };
