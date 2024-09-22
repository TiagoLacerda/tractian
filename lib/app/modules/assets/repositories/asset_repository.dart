import 'dart:developer';

import '../models/asset.dart';
import '../models/component.dart';
import '../providers/asset_provider.dart';

abstract class IAssetRepository {
  const IAssetRepository();

  Future<({List<Asset> assets, List<Component> components})> fetch({
    required String companyId,
  });
}

class AssetRepository implements IAssetRepository {
  final IAssetProvider provider;

  const AssetRepository(this.provider);

  @override
  Future<({List<Asset> assets, List<Component> components})> fetch({
    required String companyId,
  }) async {
    try {
      final response = await provider.fetch(
        companyId: companyId,
      );

      final assets = <Asset>[];
      final components = <Component>[];

      for (var item in response) {
        if (item['sensorType'] == null) {
          assets.add(Asset.fromMap(item));
        } else {
          components.add(Component.fromMap(item));
        }
      }

      return (assets: assets, components: components);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
