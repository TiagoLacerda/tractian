import 'dart:developer';

import '../models/company.dart';
import '../repositories/company_repository.dart';

abstract class IFetchCompaniesUsecase {
  const IFetchCompaniesUsecase();

  Future<List<Company>> call();
}

class FetchCompaniesUsecase implements IFetchCompaniesUsecase {
  final ICompanyRepository repository;

  const FetchCompaniesUsecase(this.repository);

  @override
  Future<List<Company>> call() async {
    try {
      return await repository.fetch();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
