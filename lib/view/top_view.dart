import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/viewmodel/top_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopView extends ConsumerWidget {
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
          if (context.mounted) context.go('/room_preparation_view');
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage('asset/image/warrior.png'),
              width: 300,
              height: 300,
            ),
            Text(
              '宿題マスター',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.asset(
                'asset/image/fire.gif',
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUsername(BuildContext context, TopViewModel vm) async {
    final username = await dialogService.showNameRegistrationDialog(context);
    if (context.mounted) {
      final isSuccess =
          await dialogService.showNameConfirmationDialog(context, username!);
      if (context.mounted && isSuccess) {
        try {
          await vm.saveUsername(username);
          if (context.mounted) context.go('/room_preparation_view');
        } catch (e) {
          if (context.mounted) {
            dialogService.showErrorDialog(context, '名前の保存中にエラーが発生しました');
          }
        }
      }
    }
  }
}
