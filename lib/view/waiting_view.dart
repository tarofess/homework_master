import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  final String? roomID;

  const WaitingView({super.key, required this.roomID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(roomID == null ? '' : 'ルームID : $roomID')),
      body: buildBody(context, ref),
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    return roomID == null ? Container() : Container();
  }
}
