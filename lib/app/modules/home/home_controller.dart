import 'dart:developer';

import 'package:flutter/material.dart';

import '../assets/assets_module.dart';
import 'models/company.dart';

class HomeController {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final List<Company> companies = <Company>[];

  Future<void> initialize(BuildContext context) async {
    await load(context);
  }

  Future<void> load(BuildContext context) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      // TODO: Load companies

      await Future.delayed(const Duration(seconds: 3));

      companies.clear();
      companies.addAll(
        [
          const Company(id: '662fd0ee639069143a8fc387', name: 'Jaguar'),
          const Company(id: '662fd0fab3fd5656edb39af5', name: 'Tobias'),
          const Company(id: '662fd100f990557384756e58', name: 'Apex'),
        ],
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onPressedCompanyWidget(BuildContext context) async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AssetsModule(),
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
