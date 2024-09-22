import 'package:flutter/material.dart';

import 'assets_controller.dart';
import 'assets_view.dart';

class AssetsModule extends StatefulWidget {
  const AssetsModule({super.key});

  @override
  State<AssetsModule> createState() => _AssetsModuleState();
}

class _AssetsModuleState extends State<AssetsModule> {
  late final AssetsController controller;

  @override
  void initState() {
    super.initState();

    controller = AssetsController();

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
    return AssetsView(
      controller: controller,
    );
  }
}
