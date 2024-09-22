import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

abstract class IAssetProvider {
  const IAssetProvider();

  Future<List<Map<String, dynamic>>> fetch({
    required String companyId,
  });
}

class AssetProvider implements IAssetProvider {
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
          'companies/$companyId/assets',
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
