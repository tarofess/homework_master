// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Homework _$HomeworkFromJson(Map<String, dynamic> json) {
  return _Homework.fromJson(json);
}

/// @nodoc
mixin _$Homework {
  int get startTime => throw _privateConstructorUsedError;
  Map<String, Result> get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeworkCopyWith<Homework> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeworkCopyWith<$Res> {
  factory $HomeworkCopyWith(Homework value, $Res Function(Homework) then) =
      _$HomeworkCopyWithImpl<$Res, Homework>;
  @useResult
  $Res call({int startTime, Map<String, Result> result});
}

/// @nodoc
class _$HomeworkCopyWithImpl<$Res, $Val extends Homework>
    implements $HomeworkCopyWith<$Res> {
  _$HomeworkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, Result>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeworkImplCopyWith<$Res>
    implements $HomeworkCopyWith<$Res> {
  factory _$$HomeworkImplCopyWith(
          _$HomeworkImpl value, $Res Function(_$HomeworkImpl) then) =
      __$$HomeworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int startTime, Map<String, Result> result});
}

/// @nodoc
class __$$HomeworkImplCopyWithImpl<$Res>
    extends _$HomeworkCopyWithImpl<$Res, _$HomeworkImpl>
    implements _$$HomeworkImplCopyWith<$Res> {
  __$$HomeworkImplCopyWithImpl(
      _$HomeworkImpl _value, $Res Function(_$HomeworkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? result = null,
  }) {
    return _then(_$HomeworkImpl(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, Result>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeworkImpl implements _Homework {
  const _$HomeworkImpl(
      {required this.startTime, required final Map<String, Result> result})
      : _result = result;

  factory _$HomeworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeworkImplFromJson(json);

  @override
  final int startTime;
  final Map<String, Result> _result;
  @override
  Map<String, Result> get result {
    if (_result is EqualUnmodifiableMapView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_result);
  }

  @override
  String toString() {
    return 'Homework(startTime: $startTime, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeworkImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, startTime, const DeepCollectionEquality().hash(_result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeworkImplCopyWith<_$HomeworkImpl> get copyWith =>
      __$$HomeworkImplCopyWithImpl<_$HomeworkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeworkImplToJson(
      this,
    );
  }
}

abstract class _Homework implements Homework {
  const factory _Homework(
      {required final int startTime,
      required final Map<String, Result> result}) = _$HomeworkImpl;

  factory _Homework.fromJson(Map<String, dynamic> json) =
      _$HomeworkImpl.fromJson;

  @override
  int get startTime;
  @override
  Map<String, Result> get result;
  @override
  @JsonKey(ignore: true)
  _$$HomeworkImplCopyWith<_$HomeworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
