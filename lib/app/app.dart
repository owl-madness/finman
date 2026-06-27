import 'package:flutter/material.dart';

class FinManApp extends StatelessWidget {
  const FinManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinMan',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: Center(child: Text('FinMan'))),
    );
  }
}
