import 'dart:developer';

import 'package:flutter/material.dart';

import '../assets/assets_module.dart';
import 'models/company.dart';
import 'usecases/fetch_companies_usecase.dart';

class HomeController {
  final IFetchCompaniesUsecase fetchCompaniesUsecase;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final List<Company> companies = <Company>[];

  HomeController(
    this.fetchCompaniesUsecase,
  );

  Future<void> initialize(BuildContext context) async {
    await load(context);
  }

  Future<void> load(BuildContext context) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final companies = await fetchCompaniesUsecase();

      this.companies.clear();
      this.companies.addAll(companies);
    } catch (e) {
      log(e.toString());

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Ocorreu um erro!'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onPressedCompanyWidget(
      BuildContext context, Company company) async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AssetsModule(),
          settings: RouteSettings(
            arguments: {
              'companyId': company.id,
            },
          ),
        ),
      );
    } catch (e) {
      log(e.toString());

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Ocorreu um erro!'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void dispose() {
    isLoading.dispose();
  }
}
