import 'package:freezed_annotation/freezed_annotation.dart';

part 'players.freezed.dart';

@freezed
class Players with _$Players {
  const factory Players({
    required String id,
    required String name,
  }) = _Players;
}
