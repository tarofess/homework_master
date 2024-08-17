import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_master/view/top_view.dart';

class NavigationService {
  GoRouter getRouter() {
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const TopView();
          },
        ),
      ],
    );

    return router;
  }
}
