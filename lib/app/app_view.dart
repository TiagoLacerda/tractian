import 'package:flutter/material.dart';

import 'app_controller.dart';
import 'core/theme/app_theme.dart';
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
      theme: AppTheme.theme,
      home: const HomeModule(),
    );
  }
}
