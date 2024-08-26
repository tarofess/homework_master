import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankingViewModel {
  final roomRepositoryService = getIt<RoomRepositoryService>();

  Future<ui.Image> captureScreenshot(GlobalKey globalKey) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    return image;
  }

  Future<void> saveAndShareScreenshot(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/screenshot.png').create();
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> deleteRoom(String roomID) async {
    await roomRepositoryService.deleteRoom(roomID);
  }
}

final rankingViewModelProvider = Provider((ref) => RankingViewModel());
