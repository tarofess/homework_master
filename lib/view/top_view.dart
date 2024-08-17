import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopView extends ConsumerWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return const Center(
      child: Text('TopView'),
    );
  }
}
