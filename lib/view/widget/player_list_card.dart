import 'package:flutter/material.dart';
import 'package:homework_master/model/homework.dart';
import 'package:homework_master/model/room.dart';

class PlayerListCard extends StatelessWidget {
  final PlayerListCardType type;
  final Room room;
  final int index;

  const PlayerListCard(
      {super.key, required this.type, required this.room, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: type == PlayerListCardType.waiting
            ? null
            : Text(
                '${index + 1}位',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                    ),
              ),
        title: Text(
          type == PlayerListCardType.waiting
              ? room.playersList[index].value.name
              : room.player[room.homework!.resultsList[index].key]!.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
        ),
        trailing: type == PlayerListCardType.waiting
            ? null
            : Text(
                room.homework?.getFormattedClearTime(
                        room.homework?.resultsList[index].value.clearTime) ??
                    '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
              ),
      ),
    );
  }
}

enum PlayerListCardType { ranking, waiting }
