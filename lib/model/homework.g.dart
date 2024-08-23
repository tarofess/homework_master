// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeworkImpl _$$HomeworkImplFromJson(Map<String, dynamic> json) =>
    _$HomeworkImpl(
      startTime: (json['startTime'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HomeworkImplToJson(_$HomeworkImpl instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'results': instance.results,
    };
