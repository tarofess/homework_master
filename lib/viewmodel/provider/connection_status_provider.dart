import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';

class ConnectionStatusNotifier extends StateNotifier<bool> {
  ConnectionStatusNotifier() : super(true) {
    monitorConnection();
  }

  void monitorConnection() {
    final connectedRef = FirebaseDatabase.instance.ref(".info/connected");
    connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;
      state = connected;
    });
  }
}

final connectionStatusProvider =
    StateNotifierProvider<ConnectionStatusNotifier, bool>((ref) {
  return ConnectionStatusNotifier();
});
