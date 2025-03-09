import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/main_navigation.dart';

final class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'main',
        builder: (context, state) => const MainNavigation(),
        routes: const [],
      ),
    ],
    errorBuilder: (context, state) => Material(
      child: Center(
        child: Text(
          'Page not found: ${state.uri}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    ),
  );

  // Named routes
  static const main = '/';
  static const search = '/search';

  // Navigation methods
  static void goMain(BuildContext context) => context.goNamed('main');
}
