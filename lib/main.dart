import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/service/dialog_service.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:homework_master/view/room_preparation_view.dart';
import 'package:homework_master/view/top_view.dart';
import 'package:homework_master/view/waiting_view.dart';
import 'package:homework_master/view/widget/app_theme.dart';
import 'package:homework_master/view/widget/common_async_widget.dart';
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
      routerConfig: getRouter(),
      theme: AppTheme.defaultTheme(),
    );
  }

  GoRouter getRouter() {
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          name: 'top_view',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return TopView();
          },
        ),
        GoRoute(
          name: 'room_preparation_view',
          path: '/room_preparation_view',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: RoomPreparationView(),
              transitionDuration: const Duration(milliseconds: 800),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.fastLinearToSlowEaseIn;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),
        GoRoute(
          name: 'waiting_view',
          path: '/room_preparation_view/waiting_view',
          builder: (BuildContext context, GoRouterState state) {
            final roomID = state.extra as String?;
            return WaitingView(roomID: roomID);
          },
        ),
      ],
    );

    return router;
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
}
