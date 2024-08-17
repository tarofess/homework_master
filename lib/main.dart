import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:homework_master/service/navigation_service.dart';
import 'package:homework_master/view/widget/common_async_widget';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';

void main() {
  setupGetIt();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(initializationProvider);

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: initialization.when(
          data: (_) => AppRouter(),
          error: (error, stackTrace) => showInitializationrErrorMessage(
              context, ref, initializationProvider, error),
          loading: () => CommonAsyncWidget.showLoadingIndicator(),
        ),
      ),
    );
  }

  Widget showInitializationrErrorMessage(BuildContext context, WidgetRef ref,
      FutureProvider provider, Object error) {
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
                  const Text('アプリの初期化中にエラーが発生しました'),
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
              ref.refresh(provider);
            },
            child: const Text('リトライ'),
          ),
        ],
      ),
    );
  }
}

class AppRouter extends StatelessWidget {
  final navigationService = getIt<NavigationService>();

  AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: navigationService.getRouter(),
    );
  }
}

Future<void> setupFirebase() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    throw Exception('Firebaseの初期化に失敗しました');
  }
}

final initializationProvider = FutureProvider<void>((ref) async {
  return await setupFirebase();
});

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton(() => NavigationService());
}
