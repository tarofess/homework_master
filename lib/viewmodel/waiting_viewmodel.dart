import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingViewModel {
  Future<void> closeRoom() async {
    // ここに部屋を解散する処理を書く
  }

  Future<void> leaveRoom() async {
    // ここに部屋を退出する処理を書く
  }
}

final waitingViewModelProvider = Provider((ref) => WaitingViewModel());
