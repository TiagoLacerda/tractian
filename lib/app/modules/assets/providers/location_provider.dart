import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

abstract class ILocationProvider {
  const ILocationProvider();

  Future<List<Map<String, dynamic>>> fetch({
    required String companyId,
  });
}

class LocationProvider implements ILocationProvider {
  @override
  Future<List<Map<String, dynamic>>> fetch({
    required String companyId,
  }) async {
    Client? client;

    try {
      client = Client();

      final response = await client.get(
        Uri.https(
          'fake-api.tractian.com',
          'companies/$companyId/locations',
        ),
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    } finally {
      client?.close();
    }
  }
}
