// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeworkImpl _$$HomeworkImplFromJson(Map<String, dynamic> json) =>
    _$HomeworkImpl(
      startTime: (json['startTime'] as num).toInt(),
      result: (json['result'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Result.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$HomeworkImplToJson(_$HomeworkImpl instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'result': instance.result,
    };
