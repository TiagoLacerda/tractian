import 'dart:developer';

import '../models/company.dart';
import '../providers/company_provider.dart';

abstract class ICompanyRepository {
  const ICompanyRepository();

  Future<List<Company>> fetch();
}

class CompanyRepository implements ICompanyRepository {
  final ICompanyProvider provider;

  const CompanyRepository(this.provider);

  @override
  Future<List<Company>> fetch() async {
    try {
      final response = await provider.fetch();

      return response.map((e) => Company.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
