import 'dart:developer';

import '../models/location.dart';
import '../repositories/location_repository.dart';

abstract class IFetchLocationsUsecase {
  const IFetchLocationsUsecase();

  Future<List<Location>> call({
    required String companyId,
  });
}

class FetchLocationsUsecase implements IFetchLocationsUsecase {
  final ILocationRepository repository;

  const FetchLocationsUsecase(this.repository);

  @override
  Future<List<Location>> call({
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
