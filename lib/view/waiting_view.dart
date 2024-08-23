import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/model/room.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
import 'package:homework_master/viewmodel/provider/owner_check_provider.dart';
import 'package:homework_master/viewmodel/provider/waiting_players_provider.dart';
import 'package:homework_master/viewmodel/waiting_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  final String roomID;
  final dialogService = getIt<DialogService>();
  final roomRepositoryService = getIt<RoomRepositoryService>();

  WaitingView({super.key, required this.roomID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(waitingViewModelProvider);
    final isOwner = ref.watch(ownerCheckProvider);

    return Scaffold(
      appBar: buildAppBar(context, vm, isOwner),
      body: buildBody(context, vm, ref),
    );
  }

  AppBar buildAppBar(BuildContext context, WaitingViewModel vm, bool isOwner) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          try {
            await handleRoomExit(context, vm, isOwner);
          } catch (e) {
            if (context.mounted) {
              dialogService.showErrorDialog(context, e.toString());
            }
          }
        },
      ),
      title: Text('ルームID : $roomID'),
      actions: [
        if (isOwner)
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () async {
              try {
                await handleRoomReadyConfirmation(context, vm);
              } catch (e) {
                if (context.mounted) {
                  dialogService.showErrorDialog(context, e.toString());
                }
              }
            },
          ),
      ],
    );
  }

  Widget buildBody(BuildContext context, WaitingViewModel vm, WidgetRef ref) {
    final room = ref.watch(waitingPlayersProvider(roomID));
    checkRoomStatus(context, vm, room.value);

    return room.when(
        data: (data) => data == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('オーナーがこの部屋を解散しました'),
                    Text('またのご利用お待ちしています'),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: data.players.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.players[index].name),
                  );
                },
              ),
        error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('エラーが発生しました'),
                          const Text('しばらく経ってから再度お試しください'),
                          const SizedBox(height: 40),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        loading: () => CommonAsyncWidget.showLoadingIndicator());
  }

  Future<void> handleRoomExit(
      BuildContext context, WaitingViewModel vm, bool isOwner) async {
    bool isSuccess = false;

    if (isOwner) {
      isSuccess = await dialogService.showLeaveDialog(
          context, 'この部屋を解散しますか？', () => vm.closeRoom(roomID));
    } else {
      isSuccess = await dialogService.showLeaveDialog(
          context, 'この部屋を退出しますか？', () => vm.leaveRoom(roomID));
    }

    if (isSuccess) {
      if (context.mounted) GoRouter.of(context).pop();
    }
  }

  Future<void> handleRoomReadyConfirmation(
      BuildContext context, WaitingViewModel vm) async {
    final isSuccess = await dialogService.showConfirmationDialog(
        context, '準備OK？', 'メンバーがそろいましたか？\n準備が完了したらはいを押してください');
    if (isSuccess) {
      await roomRepositoryService.updateRoomStatus(roomID, 'ready');
      if (context.mounted) {
        context.goNamed('homework_view');
      }
    }
  }

  void checkRoomStatus(BuildContext context, WaitingViewModel vm, Room? room) {
    if (vm.isRoomStateReady(room)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed('homework_view');
      });
    }
  }
}
