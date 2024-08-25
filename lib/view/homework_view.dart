import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/view/widget/homework_start_animation.dart';
import 'package:homework_master/view/widget/homework_timer.dart';
import 'package:homework_master/view/widget/loading_overlay.dart';
import 'package:homework_master/viewmodel/homework_viewmodel.dart';
import 'package:homework_master/viewmodel/provider/homework_timer_provider.dart';
import 'package:homework_master/viewmodel/provider/roomid_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeworkView extends HookConsumerWidget {
  final dialogService = getIt<DialogService>();
  final roomRepositoryService = getIt<RoomRepositoryService>();

  HomeworkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeworkViewModelProvider);
    final roomID = ref.read(roomIDProvider);
    final isEnableFinishButton = useState(false);
    final isShowReadyTextAnimation = useState(false);
    final isShowGoTextAnimation = useState(false);
    final isShowTimer = useState(false);
    final isFinishButtonPressed = useState(false);
    final buttonColor =
        isFinishButtonPressed.value ? Colors.grey : Colors.green[400];

    useEffect(() {
      void animationSequence() async {
        await Future.delayed(const Duration(seconds: 1));
        isShowReadyTextAnimation.value = true;
        await Future.delayed(const Duration(seconds: 2));
        isEnableFinishButton.value = true;
        isShowReadyTextAnimation.value = false;
        isShowGoTextAnimation.value = true;
        isShowTimer.value = true;
        ref.read(homeworkTimerProvider.notifier).startTimer();

        await Future.delayed(const Duration(seconds: 3));
        isShowGoTextAnimation.value = false;
      }

      Future<void> addHomework() async {
        await roomRepositoryService.addHomework(roomID);
      }

      Future<void> initializeEffect() async {
        await addHomework();
        animationSequence();
      }

      try {
        initializeEffect();
      } catch (e) {
        if (context.mounted) {
          dialogService.showErrorDialog(context, e.toString());
        }
      }
      return null;
    }, []);

    return Scaffold(
        body: buildBody(
      context,
      vm,
      ref,
      roomID,
      isEnableFinishButton,
      isShowReadyTextAnimation,
      isShowGoTextAnimation,
      isShowTimer,
      isFinishButtonPressed,
      buttonColor!,
    ));
  }

  Widget buildBody(
    BuildContext context,
    HomeworkViewModel vm,
    WidgetRef ref,
    String roomID,
    ValueNotifier<bool> isEnableFinishButton,
    ValueNotifier<bool> isShowReadyTextAnimation,
    ValueNotifier<bool> isShowGoTextAnimation,
    ValueNotifier<bool> isShowTimer,
    ValueNotifier<bool> isFinishButtonPressed,
    Color buttonColor,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: buttonColor,
              minimumSize: const Size(300, 300),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
              ),
              elevation: 12,
            ),
            onPressed: isEnableFinishButton.value
                ? () async {
                    try {
                      await handleFinishButtonPressed(
                        context,
                        vm,
                        ref,
                        roomID,
                        isFinishButtonPressed,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        dialogService.showErrorDialog(context, e.toString());
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
        if (isShowTimer.value)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(child: HomeworkTimer()),
          ),
        if (isShowReadyTextAnimation.value)
          const HomeworkStartAnimation(
            text: 'Ready...',
            fontSize: 40,
            duration: 1,
          ),
        if (isShowGoTextAnimation.value)
          const HomeworkStartAnimation(
            text: 'Go!',
            fontSize: 160,
            duration: 0,
          ),
      ],
    );
  }

  Future<void> handleFinishButtonPressed(
    BuildContext context,
    HomeworkViewModel vm,
    WidgetRef ref,
    String roomID,
    ValueNotifier<bool> isFinishButtonPressed,
  ) async {
    if (isFinishButtonPressed.value) {
      final result = await dialogService.showConfirmationDialog(
        context,
        '取り消し確認',
        'ひょっとしてまだ終わってなかった？\n宿題の終了を取り消しますか？',
      );

      if (!result) {
        return;
      }

      isFinishButtonPressed.value = false;

      if (context.mounted) {
        await LoadingOverlay.of(context).during(() => vm.undoHomework(roomID));
      }
      ref.read(homeworkTimerProvider.notifier).startTimer();
    } else {
      isFinishButtonPressed.value = true;
      await LoadingOverlay.of(context)
          .during(() => vm.finishedHomework(roomID));
      ref.read(homeworkTimerProvider.notifier).stopTimer();
    }
  }
}
