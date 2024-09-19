import 'package:flutter/material.dart';

import 'home_controller.dart';
import 'home_view.dart';

class HomeModule extends StatefulWidget {
  const HomeModule({super.key});

  @override
  State<HomeModule> createState() => _HomeModuleState();
}

class _HomeModuleState extends State<HomeModule> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();

    controller = HomeController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(
      controller: controller,
    );
  }
}
