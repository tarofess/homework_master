import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopView extends ConsumerWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 招待&待機画面に遷移
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage('asset/image/warrior.png'),
              width: 200,
              height: 200,
            ),
            Text(
              '宿題マスター',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Image.asset(
              'asset/image/fire.gif',
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
