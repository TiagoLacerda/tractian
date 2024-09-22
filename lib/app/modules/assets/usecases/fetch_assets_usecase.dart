import 'dart:developer';

import '../models/asset.dart';
import '../models/component.dart';
import '../repositories/asset_repository.dart';

abstract class IFetchAssetsUsecase {
  const IFetchAssetsUsecase();

  Future<({List<Asset> assets, List<Component> components})> call({
    required String companyId,
  });
}

class FetchAssetsUsecase implements IFetchAssetsUsecase {
  final IAssetRepository repository;

  const FetchAssetsUsecase(this.repository);

  @override
  Future<({List<Asset> assets, List<Component> components})> call({
    required String companyId,
  }) async {
    try {
      return await repository.fetch(
        companyId: companyId,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
