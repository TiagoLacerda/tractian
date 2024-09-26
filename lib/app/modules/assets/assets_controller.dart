import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/models/company.dart';
import '../../core/models/item.dart';
import '../../core/node.dart';
import 'usecases/get_item_tree_usecase.dart';

class AssetsController {
  final IGetItemTreeUsecase getItemTreeUsecase;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Node<Item> root = Node<Item>(value: Company(id: '', name: ''), children: []);

  /// How long it takes to trigger an automatic refresh.
  final Duration refreshDuration = const Duration(seconds: 60);

  late final Company company;

  AssetsController(
    this.getItemTreeUsecase,
  );

  Future<void> initialize(
    BuildContext context, {
    dynamic args,
  }) async {
    try {
      final map = (args as Map<String, dynamic>);

      company = map['company'];

      root = Node<Item>(value: company, children: []);

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

      final node = await getItemTreeUsecase(
        company: company,
      );

      node.foo(root, (a, b) {
        if (a.value.id == b.value.id) {
          a.value.collapsed = b.value.collapsed;
        }
      });

      root = node;
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

  void expandAll({required Node<Item> node}) {
    node.value.collapsed = false;

    for (var child in node.children) {
      expandAll(node: child);
    }
  }

  void collapseAll({required Node<Item> node}) {
    node.value.collapsed = true;

    for (var child in node.children) {
      collapseAll(node: child);
    }
  }

  void dispose() {
    isLoading.dispose();
  }
}
