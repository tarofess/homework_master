import 'package:flutter/material.dart';
import 'package:homework_master/viewmodel/room_preparation_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('部屋名')),
      body: buildBody(context, ref),
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    final isOwner = ref.watch(isOwnerProvider);
    return isOwner ? const Center(child: Text('Owner')) : Container();
  }
}
