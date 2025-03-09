import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moniepoint_assessment/core/router/app_router.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

void main() {
  debugPrint = (String? message, {int? wrapWidth}) => debugPrintSynchronously(message, wrapWidth: wrapWidth);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Real Estate App',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return Builder(builder: (context) => child!);
      },
    );
  }
}
