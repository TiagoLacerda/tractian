import 'dart:developer';

import '../models/location.dart';
import '../providers/Location_provider.dart';

abstract class ILocationRepository {
  const ILocationRepository();

  Future<List<Location>> fetch({
    required String companyId,
  });
}

class LocationRepository implements ILocationRepository {
  final ILocationProvider provider;

  const LocationRepository(this.provider);

  @override
  Future<List<Location>> fetch({
    required String companyId,
  }) async {
    try {
      final response = await provider.fetch(
        companyId: companyId,
      );

      return response.map((e) => Location.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
