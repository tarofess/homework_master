import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/view/widget/homework_start_animation.dart';
import 'package:homework_master/viewmodel/homework_viewmodel.dart';
import 'package:homework_master/viewmodel/provider/owner_check_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkView extends HookConsumerWidget {
  final dialogService = getIt<DialogService>();

  HomeworkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeworkViewModelProvider);
    final isOwner = ref.watch(ownerCheckProvider);

    useEffect(() {
      void showAnimation() async {
        await Future.delayed(const Duration(seconds: 1));
        const HomeworkStartAnimation(text: 'Ready Go!');
        await Future.delayed(const Duration(seconds: 1));
      }

      showAnimation();
      return null;
    }, []);

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(title: const Text('宿題やってます！'));
  }

  Widget buildBody() {
    return Container();
  }
}
