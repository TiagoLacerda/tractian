import 'dart:developer';

import 'package:flutter/material.dart' hide RefreshProgressIndicator;

import 'assets_controller.dart';
import 'widgets/refresh_progress_indicator.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            const Placeholder(),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              color: Color(0xFFEAEEF2),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (context, value, child) {
                  log(value.toString());

                  if (value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Placeholder();
                  }
                },
              ),
            ),
            RefreshProgressIndicator(
              duration: controller.refreshDuration,
              onComplete: () => controller.load(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.load(context),
        child: const Icon(
          Icons.refresh_outlined,
        ),
      ),
    );
  }
}
