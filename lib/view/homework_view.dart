import 'package:flutter/material.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/viewmodel/homework_viewmodel.dart';
import 'package:homework_master/viewmodel/provider/owner_check_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkView extends ConsumerWidget {
  final dialogService = getIt<DialogService>();

  HomeworkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeworkViewModelProvider);
    final isOwner = ref.watch(ownerCheckProvider);

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(title: const Text('宿題やってます！'));
  }

  Widget buildBody() {
    return const Center(child: Text('宿題画面'));
  }
}
