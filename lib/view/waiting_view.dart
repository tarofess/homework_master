import 'package:flutter/material.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
import 'package:homework_master/viewmodel/provider/waiting_players_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingView extends ConsumerWidget {
  final String roomID;

  const WaitingView({super.key, required this.roomID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('ルームID : $roomID')),
      body: buildBody(context, ref),
    );
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
