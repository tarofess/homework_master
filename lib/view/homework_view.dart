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
    final showReadyAnimation = useState(false);
    final showGoAnimation = useState(false);

    useEffect(() {
      void animationSequence() async {
        await Future.delayed(const Duration(seconds: 1));
        showReadyAnimation.value = true;
        await Future.delayed(const Duration(seconds: 2));
        showReadyAnimation.value = false;
        showGoAnimation.value = true;
        await Future.delayed(const Duration(seconds: 3));
        showGoAnimation.value = false;
      }

      animationSequence();
      return null;
    }, []);

    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          buildBody(),
          if (showReadyAnimation.value)
            const HomeworkStartAnimation(
              text: 'Ready...',
              fontSize: 40,
              duration: 1,
            ),
          if (showGoAnimation.value)
            const HomeworkStartAnimation(
              text: 'Go!',
              fontSize: 160,
              duration: 0,
            ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(title: const Text('宿題やってます！'));
  }

  Widget buildBody() {
    return Container();
  }
}
