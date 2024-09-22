import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/item.dart';
import 'usecases/fetch_assets_usecase.dart';
import 'usecases/fetch_locations_usecase.dart';

class AssetsController {
  final IFetchAssetsUsecase fetchAssetsUsecase;
  final IFetchLocationsUsecase fetchLocationsUsecase;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final List<Item> items = <Item>[];

  /// How long it takes to trigger an automatic refresh.
  final Duration refreshDuration = const Duration(seconds: 30);

  late final String companyId;

  AssetsController(
    this.fetchAssetsUsecase,
    this.fetchLocationsUsecase,
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

      // TODO: POP and show error dialog
    }
  }

  Future<void> load(BuildContext context) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final locations = await fetchLocationsUsecase(
        companyId: companyId,
      );

      final (:assets, :components) = await fetchAssetsUsecase(
        companyId: companyId,
      );

      items.clear();
      items.addAll(locations);
      items.addAll(assets);
      items.addAll(components);

      log('Loaded a total of ${items.length} items.');
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
