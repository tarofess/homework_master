import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationView extends ConsumerWidget {
  final dialogService = getIt<DialogService>();

  RoomPreparationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 20),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildMakeRoomButton(context),
          buildWaitButton(context),
        ],
      ),
    );
  }

  Widget buildMakeRoomButton(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 40.0, right: 40.0, top: 0, bottom: 25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orangeAccent[100],
            minimumSize: const Size(double.infinity, double.infinity),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(20),
              ),
            ),
            elevation: 12,
          ),
          onPressed: () async {
            try {
              await makeRoom(context);
            } catch (e) {
              if (context.mounted) {
                await dialogService.showErrorDialog(
                    context, '部屋の作成に失敗しました\nもう一度お試しください');
              }
            }
          },
          child: Text('部屋を作る',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 30)),
        ),
      ),
    );
  }

  Widget buildWaitButton(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 40.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent[100],
            minimumSize: const Size(double.infinity, double.infinity),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(20),
              ),
            ),
            elevation: 12,
          ),
          onPressed: () async {
            try {
              await enterWaitingRoom(context);
            } catch (e) {
              if (context.mounted) {
                await dialogService.showErrorDialog(
                    context, 'そのような部屋は存在しません\n部屋名をもう一度確認してください');
              }
            }
          },
          child: Text('待機する',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 30)),
        ),
      ),
    );
  }

  Future<void> makeRoom(BuildContext context) async {
    final isSuccess = await dialogService.showMakeRoomDialog(context);
    if (isSuccess) {
      if (context.mounted) context.pushNamed('waiting_view');
    }
  }

  Future<void> enterWaitingRoom(BuildContext context) async {
    final isSuccess = await dialogService.showEnterRoomNameDialog(context);
    if (isSuccess) {
      if (context.mounted) context.pushNamed('waiting_view');
    }
  }
}
