import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/item.dart';

class AssetsController {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final List<Item> items = <Item>[];

  /// How long it takes to trigger an automatic refresh.
  final Duration refreshDuration = const Duration(seconds: 5);

  AssetsController();

  Future<void> initialize(BuildContext context) async {
    await load(context);
  }

  Future<void> load(BuildContext context) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 10));

      // final items = await fetchItemsUsecase();

      // this.items.clear();
      // this.items.addAll(companies);
    } catch (e) {
      log(e.toString());

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Ocorreu um erro!'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void dispose() {
    isLoading.dispose();
  }
}
