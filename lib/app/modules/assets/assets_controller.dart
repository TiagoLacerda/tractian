import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/node.dart';
import 'models/item.dart';
import 'usecases/get_item_tree_usecase.dart';

class AssetsController {
  final IGetItemTreeUsecase getItemTreeUsecase;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Node<Item?> root = const Node<Item?>(value: null, children: []);

  /// How long it takes to trigger an automatic refresh.
  final Duration refreshDuration = const Duration(seconds: 30);

  late final String companyId;

  AssetsController(
    this.getItemTreeUsecase,
  );

  Future<void> initialize(
    BuildContext context, {
    dynamic args,
  }) async {
    try {
      final map = (args as Map<String, dynamic>);

      companyId = map['companyId'];

      await load(context);
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
    }
  }

  Future<void> load(BuildContext context) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      root = await getItemTreeUsecase(
        companyId: companyId,
      );
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
