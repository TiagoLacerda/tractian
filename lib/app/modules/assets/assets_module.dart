import 'package:flutter/material.dart';

import 'assets_controller.dart';
import 'assets_view.dart';
import 'providers/Location_provider.dart';
import 'providers/asset_provider.dart';
import 'repositories/asset_repository.dart';
import 'repositories/location_repository.dart';
import 'usecases/fetch_assets_usecase.dart';
import 'usecases/fetch_locations_usecase.dart';
import 'usecases/get_item_tree_usecase.dart';

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

    controller = AssetsController(
      GetItemTreeUsecase(
        FetchAssetsUsecase(
          AssetRepository(
            AssetProvider(),
          ),
        ),
        FetchLocationsUsecase(
          LocationRepository(
            LocationProvider(),
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(
        context,
        args: ModalRoute.of(context)?.settings.arguments,
      );
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
