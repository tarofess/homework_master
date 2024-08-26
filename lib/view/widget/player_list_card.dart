import 'package:flutter/material.dart';
import 'package:homework_master/model/homework.dart';

class PlayerListCard extends StatelessWidget {
  final String? playerName;
  final Homework? homework;
  final int? index;

  const PlayerListCard(
      {super.key, required this.playerName, this.homework, this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: index == null
            ? null
            : Text(
                '$index位',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
              ),
        title: Text(
          playerName ?? '',
          overflow: TextOverflow.ellipsis,
        ),
        trailing: index == null
            ? null
            : Text(
                homework?.formattedClearTime ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
              ),
      ),
    );
  }
}
