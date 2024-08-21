import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/view/widget/loading_overlay.dart';
import 'package:homework_master/viewmodel/room_preparation_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationView extends ConsumerWidget {
  final dialogService = getIt<DialogService>();

  RoomPreparationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(roomPreparationViewModelProvider);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 20),
      body: buildBody(context, ref, vm),
    );
  }

  Widget buildBody(
      BuildContext context, WidgetRef ref, RoomPreparationViewModel vm) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildMakeRoomButton(context, ref, vm),
          buildWaitButton(context, ref, vm),
        ],
      ),
    );
  }

  Widget buildMakeRoomButton(
      BuildContext context, WidgetRef ref, RoomPreparationViewModel vm) {
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
              ref.read(isOwnerProvider.notifier).state = true;
              await LoadingOverlay.of(context).during(
                () => makeRoom(context, vm),
              );
            } catch (e) {
              if (context.mounted) {
                await dialogService.showErrorDialog(context, e.toString());
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

  Widget buildWaitButton(
      BuildContext context, WidgetRef ref, RoomPreparationViewModel vm) {
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
              ref.read(isOwnerProvider.notifier).state = false;
              await LoadingOverlay.of(context).during(
                () => enterWaitingRoom(context, vm),
              );
            } catch (e) {
              if (context.mounted) {
                await dialogService.showErrorDialog(context, e.toString());
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

  Future<void> makeRoom(
      BuildContext context, RoomPreparationViewModel vm) async {
    final roomID =
        await dialogService.showMakeRoomDialog(context, vm.requestMakeRoom);
    if (roomID.isNotEmpty) {
      if (context.mounted) {
        context.pushNamed('waiting_view', extra: roomID);
      }
    }
  }

  Future<void> enterWaitingRoom(
      BuildContext context, RoomPreparationViewModel vm) async {
    final roomID = await dialogService.showEnterRoomNameDialog(
        context, vm.requestEnterRoom);
    if (roomID.isNotEmpty) {
      if (context.mounted) {
        context.pushNamed('waiting_view', extra: roomID);
      }
    }
  }
}

final isOwnerProvider = StateProvider<bool>((ref) => false);
