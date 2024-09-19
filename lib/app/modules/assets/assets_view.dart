import 'package:flutter/material.dart';

import 'assets_controller.dart';

class AssetsView extends StatelessWidget {
  final AssetsController controller;

  const AssetsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
    );
  }
}
