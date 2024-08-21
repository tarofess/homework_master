import 'package:firebase_database/firebase_database.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingViewModel {
  final sharedPreferencesService = getIt<SharedPreferencesService>();

  Future<void> closeRoom(String roomID) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).remove();
  }

  Future<void> leaveRoom(String roomID) async {
    final userID = await sharedPreferencesService.getUserID();
    if (userID == null) return;

    final DatabaseReference ref = FirebaseDatabase.instance.ref('room');
    await ref.child(roomID).child('players').child(userID).remove();
  }
}

final waitingViewModelProvider = Provider((ref) => WaitingViewModel());
