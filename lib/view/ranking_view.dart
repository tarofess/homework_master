import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/model/homework.dart';
import 'package:homework_master/model/room.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/view/widget/bubble_animation.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
import 'package:homework_master/view/widget/player_list_card.dart';
import 'package:homework_master/viewmodel/provider/room_provider.dart';
import 'package:homework_master/viewmodel/provider/roomid_provider.dart';
import 'package:homework_master/viewmodel/ranking_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankingView extends ConsumerWidget {
  final GlobalKey globalKey = GlobalKey();
  final dialogService = getIt<DialogService>();

  RankingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomID = ref.read(roomIDProvider);

    return Scaffold(
      appBar: buildAppBar(context, ref, roomID),
      body: buildBody(context, ref, roomID),
    );
  }

  AppBar buildAppBar(BuildContext context, WidgetRef ref, String roomID) {
    final vm = ref.watch(rankingViewModelProvider);
    return AppBar(
      title: const Text('ランキング'),
      leading: IconButton(
        icon: const Icon(Icons.share),
        onPressed: () async {
          try {
            final result = await dialogService.showConfirmationDialog(
                context, '自慢しよう！', 'ランキングを誰かにシェアしますか？');
            if (!result) {
              return;
            }
            final screenshot = await vm.captureScreenshot(globalKey);
            await vm.saveAndShareScreenshot(screenshot);
          } catch (e) {
            if (context.mounted) {
              dialogService.showErrorDialog(context, e.toString());
            }
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            final result = await dialogService.showConfirmationDialog(
                context, 'お疲れさま！', 'この部屋から退出しますか？');
            if (!result) {
              return;
            }
            await vm.deleteRoom(roomID);
            if (context.mounted) context.goNamed('top_view');
          },
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref, String roomID) {
    final room = ref.watch(roomProvider(roomID));
    return room.when(
        data: (data) {
          return Container(
            color: Colors.white,
            child: RepaintBoundary(
              key: globalKey,
              child: Stack(children: [
                const BubbleAnimation(),
                ListView.builder(
                  itemCount: data?.homework?.resultsList.length,
                  itemBuilder: (context, index) {
                    return PlayerListCard(
                      playerName:
                          data?.homework?.resultsList[index].value.username,
                      homework: data?.homework,
                      index: index + 1,
                      key: ValueKey(data?.playersList[index].key),
                    );
                  },
                ),
              ]),
            ),
          );
        },
        error: (error, stackTrace) => CommonAsyncWidget.showFetchErrorMessage(
            context, ref, roomProvider, error, roomID),
        loading: () => CommonAsyncWidget.showLoadingIndicator());
  }
}
