import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  final String? roomNumber;

  const WaitingView({super.key, required this.roomNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar:
          AppBar(title: Text(roomNumber == null ? '' : 'ルームナンバー：$roomNumber')),
      body: buildBody(context, ref),
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    return roomNumber == null ? Container() : Container();
  }
}
