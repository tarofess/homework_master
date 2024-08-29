import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/service/error_handling_service.dart';
import 'package:homework_master/viewmodel/provider/connection_status_provider.dart';
import 'package:homework_master/viewmodel/provider/owner_check_provider.dart';
import 'package:homework_master/viewmodel/provider/roomid_provider.dart';
import 'package:homework_master/viewmodel/room_preparation_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoomPreparationView extends ConsumerWidget {
  final dialogService = getIt<DialogService>();
  final errorHandlingService = getIt<ErrorHandlingService>();

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
    final connectionState = ref.watch(connectionStatusProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildMakeRoomButton(context, ref, vm, connectionState),
          buildEnterRoomButton(context, ref, vm, connectionState),
        ],
      ),
    );
  }

  Widget buildMakeRoomButton(BuildContext context, WidgetRef ref,
      RoomPreparationViewModel vm, bool connectionState) {
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
          onPressed: connectionState == true
              ? () async {
                  ref.read(ownerCheckProvider.notifier).state = true;
                  await makeRoom(context, ref, vm);
                }
              : null,
          child: Text('部屋を作る',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 30)),
        ),
      ),
    );
  }

  Widget buildEnterRoomButton(BuildContext context, WidgetRef ref,
      RoomPreparationViewModel vm, connectionState) {
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
          onPressed: connectionState == true
              ? () async {
                  ref.read(ownerCheckProvider.notifier).state = false;
                  await enterWaitingRoom(context, ref, vm);
                }
              : null,
          child: Text('入室する',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 30)),
        ),
      ),
    );
  }

  Future<void> makeRoom(
      BuildContext context, WidgetRef ref, RoomPreparationViewModel vm) async {
    final roomID =
        await dialogService.showMakeRoomDialog(context, vm.requestMakeRoom);
    if (roomID.isNotEmpty && context.mounted) {
      ref.read(roomIDProvider.notifier).state = roomID;
      context.pushNamed('waiting_view');
    }
  }

  Future<void> enterWaitingRoom(
      BuildContext context, WidgetRef ref, RoomPreparationViewModel vm) async {
    final roomID = await dialogService.showEnterRoomNameDialog(
        context, vm.requestEnterRoom);

    if (vm.isRoomIdExists(roomID)) {
      ref.read(roomIDProvider.notifier).state = roomID!;
      if (context.mounted) {
        context.pushNamed('waiting_view');
      }
    } else if (vm.isRoomIdNotFound(roomID) && context.mounted) {
      dialogService.showErrorDialog(
        context,
        'ルームIDが一致しません',
        'そのような部屋は見つかりませんでした',
      );
    }
  }
}
