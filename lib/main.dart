import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/service/error_handling_service.dart';
import 'package:homework_master/service/room_repository_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:homework_master/view/widget/app_theme.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:homework_master/go_router_config.dart';

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
      home: Scaffold(
        body: initialization.when(
          data: (_) => const AppRouter(),
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
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouterConfig.getRouter(),
      theme: AppTheme.defaultTheme(),
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
  getIt.registerLazySingleton(() => SharedPreferencesService());
  getIt.registerLazySingleton(() => DialogService());
  getIt.registerLazySingleton(() => RoomRepositoryService());
  getIt.registerLazySingleton(() => ErrorHandlingService());
}
