import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/view/widget/homework_start_animation.dart';
import 'package:homework_master/view/widget/homework_timer.dart';
import 'package:homework_master/view/widget/loading_overlay.dart';
import 'package:homework_master/viewmodel/homework_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkView extends HookConsumerWidget {
  final dialogService = getIt<DialogService>();

  HomeworkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeworkViewModelProvider);
    final isEnableFinishButton = useState(false);
    final isShowReadyAnimation = useState(false);
    final isShowGoAnimation = useState(false);
    final isShowTimer = useState(false);

    useEffect(() {
      void animationSequence() async {
        await Future.delayed(const Duration(seconds: 1));
        isShowReadyAnimation.value = true;
        await Future.delayed(const Duration(seconds: 2));
        isEnableFinishButton.value = true;
        isShowReadyAnimation.value = false;
        isShowGoAnimation.value = true;
        isShowTimer.value = true;
        await Future.delayed(const Duration(seconds: 3));
        isShowGoAnimation.value = false;
      }

      animationSequence();
      return null;
    }, []);

    return Scaffold(
        body: buildBody(
      context,
      vm,
      ref,
      isEnableFinishButton.value,
      isShowReadyAnimation.value,
      isShowGoAnimation.value,
      isShowTimer.value,
    ));
  }

  Widget buildBody(
    BuildContext context,
    HomeworkViewModel vm,
    WidgetRef ref,
    bool isEnableFinishButton,
    bool isShowReadyAnimation,
    bool isShowGoAnimation,
    bool isShowTimer,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green[400],
              minimumSize: const Size(300, 300),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
              ),
              elevation: 12,
            ),
            onPressed: isEnableFinishButton
                ? () async {
                    try {
                      await LoadingOverlay.of(context)
                          .during(() => vm.finishedHomework());
                    } catch (e) {
                      if (context.mounted) {
                        await dialogService.showErrorDialog(
                            context, e.toString());
                      }
                    }
                  }
                : null,
            child: Text(
              '宿題終わり！',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        if (isShowTimer)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(child: HomeworkTimer()),
          ),
        if (isShowReadyAnimation)
          const HomeworkStartAnimation(
            text: 'Ready...',
            fontSize: 40,
            duration: 1,
          ),
        if (isShowGoAnimation)
          const HomeworkStartAnimation(
            text: 'Go!',
            fontSize: 160,
            duration: 0,
          ),
      ],
    );
  }
}
