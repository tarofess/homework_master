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

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));

    canvas.drawColor(Colors.white, BlendMode.src);
    canvas.drawImage(image, Offset.zero, Paint());

    final picture = recorder.endRecording();
    return await picture.toImage(image.width, image.height);
  }

  Future<void> saveAndShareScreenshot(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/screenshot.png').create();
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(file.path)]);
  }
}

final rankingViewModelProvider = Provider((ref) => RankingViewModel());
