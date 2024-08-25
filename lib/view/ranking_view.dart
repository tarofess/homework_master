import 'package:flutter/material.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankingView extends ConsumerWidget {
  final dialogService = getIt<DialogService>();

  RankingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('ランキング'),
    );
  }

  Widget buildBody() {
    return const Center(
      child: Text('ランキング'),
    );
  }
}
