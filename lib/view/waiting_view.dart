import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container();
  }
}
