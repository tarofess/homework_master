import 'package:flutter/material.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/model/homework.dart';
import 'package:homework_master/model/room.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
import 'package:homework_master/viewmodel/provider/room_provider.dart';
import 'package:homework_master/viewmodel/provider/roomid_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankingView extends ConsumerWidget {
  final dialogService = getIt<DialogService>();

  RankingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomID = ref.read(roomIDProvider);

    return Scaffold(
      appBar: buildAppBar(ref),
      body: buildBody(context, ref, roomID),
    );
  }

  AppBar buildAppBar(WidgetRef ref) {
    return AppBar(
      title: const Text('ランキング'),
      leading: IconButton(
        icon: const Icon(Icons.camera_alt_outlined),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref, String roomID) {
    final room = ref.watch(roomProvider(roomID));
    return room.when(
        data: (data) {
          return ListView.builder(
            itemCount: data!.playersList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('${index + 1}位'),
                title: Text(data.homework!.resultsList[index].value.username),
              );
            },
          );
        },
        error: (error, stackTrace) => CommonAsyncWidget.showFetchErrorMessage(
            context, ref, roomProvider, error, roomID),
        loading: () => CommonAsyncWidget.showLoadingIndicator());
  }
}
