import 'package:flutter/material.dart';

import 'modul8/home8.dart';
import 'modul8/tujuan8.dart';

void main() {
  runApp(const Modul8App());
}

class Modul8App extends StatelessWidget {
  const Modul8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 8',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0081C9),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home8(),
        Tujuan8.routeName: (context) => const Tujuan8(),
      },
    );
  }
}
