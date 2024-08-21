import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/view/room_preparation_view.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
import 'package:homework_master/viewmodel/provider/waiting_players_provider.dart';
import 'package:homework_master/viewmodel/waiting_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  final String roomID;
  final dialogService = getIt<DialogService>();

  WaitingView({super.key, required this.roomID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(waitingViewModelProvider);
    final isOwner = ref.watch(isOwnerProvider);

    return Scaffold(
      appBar: buildAppBar(context, vm, isOwner),
      body: buildBody(context, ref),
    );
  }

  AppBar buildAppBar(BuildContext context, WaitingViewModel vm, bool isOwner) {
    return AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            bool isSuccess = false;

            if (isOwner) {
              isSuccess = await dialogService.showLeaveDialog(
                context,
                'この部屋を解散しますか？',
                () => vm.closeRoom(),
              );
            } else {
              isSuccess = await dialogService.showLeaveDialog(
                context,
                'この部屋を退出しますか？',
                () => vm.leaveRoom(),
              );
            }

            if (isSuccess) {
              if (context.mounted) GoRouter.of(context).pop();
            }
          },
        ),
        title: Text('ルームID : $roomID'));
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    final players = ref.watch(waitingPlayersProvider(roomID));
    return players.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].name),
              );
            },
          );
        },
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
}
