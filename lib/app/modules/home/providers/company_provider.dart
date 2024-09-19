import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

abstract class ICompanyProvider {
  const ICompanyProvider();

  Future<List<Map<String, dynamic>>> fetch();
}

class CompanyProvider implements ICompanyProvider {
  @override
  Future<List<Map<String, dynamic>>> fetch() async {
    Client? client;

    try {
      client = Client();

      final response = await client.get(
        Uri.https(
          'fake-api.tractian.com',
          'companies',
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
