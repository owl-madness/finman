import 'package:finman/app/router/app_router.dart';
import 'package:flutter/material.dart';

class FinManApp extends StatelessWidget {
  const FinManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FinMan',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
