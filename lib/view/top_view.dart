import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:homework_master/viewmodel/top_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopView extends ConsumerWidget {
  final sharedPreferencesService = getIt<SharedPreferencesService>();
  final dialogService = GetIt.instance<DialogService>();

  TopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(topViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: buildBody(context, vm),
    );
  }

  Widget buildBody(BuildContext context, TopViewModel vm) {
    return GestureDetector(
      onTap: () async {
        if (await vm.isFirstLaunch()) {
          if (context.mounted) await registerUsername(context, vm);
        } else {
          if (context.mounted) context.goNamed('room_preparation_view');
        }
      },
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      buildWarriorImage(),
                      buildTitleText(context),
                      buildFireAnimation(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> registerUsername(BuildContext context, TopViewModel vm) async {
    final username = await dialogService.showNameRegistrationDialog(context);
    if (context.mounted) {
      final isSuccess = await dialogService.showConfirmationDialog(
        context,
        username!,
        '一度登録すると変更できませんが、この名前でよろしいですか？',
      );
      if (context.mounted && isSuccess) {
        try {
          await sharedPreferencesService.saveUsername(username);
          if (context.mounted) context.goNamed('room_preparation_view');
        } catch (e) {
          if (context.mounted) {
            dialogService.showErrorDialog(context, '名前の保存中にエラーが発生しました');
          }
        }
      }
    }
  }

  Widget buildWarriorImage() {
    return const Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Image(
          image: AssetImage('asset/image/warrior.png'),
          width: 280,
          height: 280,
        ),
      ),
    );
  }

  Widget buildTitleText(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          '宿題マスター',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget buildFireAnimation(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Image.asset(
          'asset/image/fire.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
