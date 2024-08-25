// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  int get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, Player> get player => throw _privateConstructorUsedError;
  Homework? get homework => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {int createdAt,
      String status,
      Map<String, Player> player,
      Homework? homework});

  $HomeworkCopyWith<$Res>? get homework;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? status = null,
    Object? player = null,
    Object? homework = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Map<String, Player>,
      homework: freezed == homework
          ? _value.homework
          : homework // ignore: cast_nullable_to_non_nullable
              as Homework?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HomeworkCopyWith<$Res>? get homework {
    if (_value.homework == null) {
      return null;
    }

    return $HomeworkCopyWith<$Res>(_value.homework!, (value) {
      return _then(_value.copyWith(homework: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
          _$RoomImpl value, $Res Function(_$RoomImpl) then) =
      __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int createdAt,
      String status,
      Map<String, Player> player,
      Homework? homework});

  @override
  $HomeworkCopyWith<$Res>? get homework;
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? status = null,
    Object? player = null,
    Object? homework = freezed,
  }) {
    return _then(_$RoomImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      player: null == player
          ? _value._player
          : player // ignore: cast_nullable_to_non_nullable
              as Map<String, Player>,
      homework: freezed == homework
          ? _value.homework
          : homework // ignore: cast_nullable_to_non_nullable
              as Homework?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl(
      {required this.createdAt,
      required this.status,
      required final Map<String, Player> player,
      required this.homework})
      : _player = player;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final int createdAt;
  @override
  final String status;
  final Map<String, Player> _player;
  @override
  Map<String, Player> get player {
    if (_player is EqualUnmodifiableMapView) return _player;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_player);
  }

  @override
  final Homework? homework;

  @override
  String toString() {
    return 'Room(createdAt: $createdAt, status: $status, player: $player, homework: $homework)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._player, _player) &&
            (identical(other.homework, homework) ||
                other.homework == homework));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, createdAt, status,
      const DeepCollectionEquality().hash(_player), homework);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(
      this,
    );
  }
}

abstract class _Room implements Room {
  const factory _Room(
      {required final int createdAt,
      required final String status,
      required final Map<String, Player> player,
      required final Homework? homework}) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  int get createdAt;
  @override
  String get status;
  @override
  Map<String, Player> get player;
  @override
  Homework? get homework;
  @override
  @JsonKey(ignore: true)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
