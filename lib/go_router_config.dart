import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/view/homework_view.dart';
import 'package:homework_master/view/ranking_view.dart';
import 'package:homework_master/view/room_preparation_view.dart';
import 'package:homework_master/view/top_view.dart';
import 'package:homework_master/view/waiting_view.dart';

class GoRouterConfig {
  static GoRouter getRouter() {
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          name: 'top_view',
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: TopView(),
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
          name: 'room_preparation_view',
          path: '/room_preparation_view',
          builder: (BuildContext context, GoRouterState state) {
            return RoomPreparationView();
          },
        ),
        GoRoute(
          name: 'waiting_view',
          path: '/room_preparation_view/waiting_view',
          builder: (BuildContext context, GoRouterState state) {
            return WaitingView();
          },
        ),
        GoRoute(
          name: 'homework_view',
          path: '/room_preparation_view/waiting_view/homework_view',
          builder: (BuildContext context, GoRouterState state) {
            return HomeworkView();
          },
        ),
        GoRoute(
          name: 'ranking_view',
          path:
              '/room_preparation_view/waiting_view/homework_view/ranking_view',
          builder: (BuildContext context, GoRouterState state) {
            return RankingView();
          },
        ),
      ],
    );

    return router;
  }
}
