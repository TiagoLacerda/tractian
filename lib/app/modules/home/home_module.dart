import 'package:flutter/material.dart';

import 'home_controller.dart';
import 'home_view.dart';
import 'providers/company_provider.dart';
import 'repositories/company_repository.dart';
import 'usecases/fetch_companies_usecase.dart';

class HomeModule extends StatefulWidget {
  const HomeModule({super.key});

  @override
  State<HomeModule> createState() => _HomeModuleState();
}

class _HomeModuleState extends State<HomeModule> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();

    // TODO: Replace with Service Locator

    controller = HomeController(
      FetchCompaniesUsecase(
        CompanyRepository(
          CompanyProvider(),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(
      controller: controller,
    );
  }
}
