import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommonAsyncWidget {
  static Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget showFetchErrorMessage(BuildContext context, WidgetRef ref,
      StreamProviderFamily provider, Object error, String roomID) {
    return Center(
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
                  const Text('再度お試しください'),
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
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // ignore: unused_result
              ref.refresh(provider(roomID));
            },
            child: const Text('リトライ'),
          ),
        ],
      ),
    );
  }
}
