import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_icons.dart';
import 'home_controller.dart';
import 'widgets/company_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;

  const HomeView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, isLoading, child) {
        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset(AppIcons.logo),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 21.0,
              ),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.companies.isEmpty
                      ? const Center(
                          child: Text('Não há nenhuma empresa!'),
                        )
                      : ListView.separated(
                          itemCount: controller.companies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CompanyWidget(
                              company: controller.companies[index],
                              onPressed: (context) =>
                                  controller.onPressedCompanyWidget(context),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 40.0,
                            );
                          },
                        ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.load(context),
            child: const Icon(
              Icons.refresh_outlined,
            ),
          ),
        );
      },
    );
  }
}
