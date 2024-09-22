import 'dart:developer';

import 'package:flutter/material.dart' hide RefreshProgressIndicator;

import 'assets_controller.dart';
import 'enums/sensor_type.dart';
import 'enums/status.dart';
import 'widgets/refresh_progress_indicator.dart';

class AssetsView extends StatefulWidget {
  final AssetsController controller;

  const AssetsView({
    super.key,
    required this.controller,
  });

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  final TextEditingController textEditingController = TextEditingController();

  Pattern? filterByPattern;
  SensorType? filterBySensorType;
  Status? filterByStatus;

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              // TODO: Change font sizes globally, instead of per widget
              child: TextField(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14.0,
                    ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding: EdgeInsets.zero,
                  // TODO: This solution won't work if multi-line input is to be enabled
                  constraints: const BoxConstraints(
                    minHeight: 32.0,
                    maxHeight: 32.0,
                  ),
                  prefixIconConstraints: const BoxConstraints(),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                    ),
                    child: Icon(
                      Icons.search_outlined,
                      size: 14.0,
                      color: Color(0xFF8E98A3),
                    ),
                  ),
                  hintText: 'Buscar Ativo ou Local',
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF8E98A3),
                        fontSize: 14.0,
                      ),
                  filled: true,
                  fillColor: const Color(0xFFEAEFF3),
                  isDense: false,
                  isCollapsed: false,
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      filterByPattern == null;
                    } else {
                      filterByPattern = value;
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      setState(() {
                        if (filterBySensorType == null) {
                          filterBySensorType = SensorType.energy;
                        } else {
                          filterBySensorType = null;
                        }
                      });
                    },
                    style: filterBySensorType == null
                        ? null
                        : OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF2188FF),
                            foregroundColor: Colors.white,
                            side: BorderSide.none,
                          ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bolt_outlined,
                          size: 16.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Sensor de Energia',
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      setState(() {
                        if (filterByStatus == null) {
                          filterByStatus = Status.alert;
                        } else {
                          filterByStatus = null;
                        }
                      });
                    },
                    style: filterByStatus == null
                        ? null
                        : OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF2188FF),
                            foregroundColor: Colors.white,
                            side: BorderSide.none,
                          ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 16.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Crítico',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              color: Color(0xFFEAEEF2),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: widget.controller.isLoading,
                builder: (context, value, child) {
                  log(value.toString());

                  if (value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Placeholder();
                  }
                },
              ),
            ),
            RefreshProgressIndicator(
              duration: widget.controller.refreshDuration,
              onComplete: () => widget.controller.load(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.controller.load(context),
        child: const Icon(
          Icons.refresh_outlined,
        ),
      ),
    );
  }
}
