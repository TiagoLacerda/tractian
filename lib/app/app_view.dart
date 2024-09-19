import 'package:flutter/material.dart';

import 'app_controller.dart';
import 'modules/home/home_module.dart';

class AppView extends StatelessWidget {
  final AppController controller;

  const AppView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2188FF),
          brightness: Brightness.light,
          primary: const Color(0xFF2188FF),
          onPrimary: Colors.white,
          surfaceTint: Colors.transparent,
        ),
        useMaterial3: true,
      ).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF17192D),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2188FF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF2188FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      home: const HomeModule(),
    );
  }
}
