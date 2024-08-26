import 'package:flutter/material.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/model/room.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkViewModel {
  final roomRepositoryService = getIt<RoomRepositoryService>();
  final sharedPreferencesService = getIt<SharedPreferencesService>();

  Future<void> finishedHomework(String roomID) async {
    final userID = await sharedPreferencesService.getUserID();
    final username = await sharedPreferencesService.getUsername();
    roomRepositoryService.addResult(roomID, userID!, username!);
  }

  Future<void> undoHomework(String roomID) async {
    final userID = await sharedPreferencesService.getUserID();
    roomRepositoryService.removeResult(roomID, userID!);
  }

  bool isCreatedHomework(Room? room) {
    return room == null || room.homework == null ? true : false;
  }

  void moveToRankigViewIfAllUserFinished(
      Room? room, VoidCallback moveToRankingView) {
    if (isCreatedHomework(room)) {
      return;
    }

    bool allKeysContained = room!.player.keys
        .every((key) => room.homework!.result.containsKey(key));

    if (allKeysContained) {
      moveToRankingView();
    }
  }
}

final homeworkViewModelProvider = Provider((ref) => HomeworkViewModel());
