import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationViewModel {
  Future<void> requestMakeRoom() async {
    // ここに部屋作成処理を書く
  }

  Future<void> requestEnterRoom() async {
    // ここに入室処理を書く
  }
}

final roomPreparationViewModelProvider =
    Provider((ref) => RoomPreparationViewModel());

final isOwnerProvider = StateProvider<bool>((ref) => false);
