import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/asset.dart';
import 'models/component.dart';
import 'models/item.dart';
import 'usecases/fetch_assets_usecase.dart';
import 'usecases/fetch_locations_usecase.dart';

class AssetsController {
  final IFetchAssetsUsecase fetchAssetsUsecase;
  final IFetchLocationsUsecase fetchLocationsUsecase;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Map<String, Item> items = <String, Item>{};

  Map<String?, List<String>> children = <String?, List<String>>{
    null: [],
  };

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

      //

      final Map<String, Item> items = <String, Item>{};

      final Map<String?, List<String>> children = <String?, List<String>>{
        null: [],
      };

      // for (var item in [...locations, ...assets, ...components]) {
      //   log(jsonEncode(item.toMap()));
      // }

      for (var item in [...locations, ...assets, ...components]) {
        items[item.id] = item;

        String? parentId;

        if (item.parentId != null) {
          parentId = item.parentId;
        } else if (item is Asset && item.locationId != null) {
          parentId = item.locationId;
        } else if (item is Component && item.locationId != null) {
          parentId = item.locationId;
        }

        if (children[parentId] == null) children[parentId] = [];

        children[parentId]!.add(item.id);
      }

      //

      this.items = items;
      this.children = children;
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
