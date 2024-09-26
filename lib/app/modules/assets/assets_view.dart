import 'dart:developer';

import 'package:flutter/material.dart' hide RefreshProgressIndicator;

import 'assets_controller.dart';
import 'enums/sensor_type.dart';
import 'enums/status.dart';
import 'usecases/build_metadata_usecase.dart';
import 'widgets/item_widget.dart';
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

  Pattern? pattern;
  SensorType? sensorType;
  Status? status;

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
                    if (value.trim().isEmpty) {
                      pattern = null;
                    } else {
                      pattern = value;
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
                        if (sensorType == null) {
                          sensorType = SensorType.energy;
                        } else {
                          sensorType = null;
                        }
                      });
                    },
                    style: sensorType == null
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
                        if (status == null) {
                          status = Status.alert;
                        } else {
                          status = null;
                        }
                      });
                    },
                    style: status == null
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  return ValueListenableBuilder(
                    valueListenable: widget.controller.isLoading,
                    builder: (context, value, child) {
                      if (value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final now = DateTime.now();
                        final hour = now.hour.toString().padLeft(2, '0');
                        final minute = now.minute.toString().padLeft(2, '0');
                        final second = now.second.toString().padLeft(2, '0');

                        final message = '''
[$hour:$minute:$second]: Will build metadata: 
  pattern: $pattern,
  sensorType: $sensorType,
  status: $status
''';

                        log(message);

                        final metadata = BuildMetadataUsecase().call(
                          items: widget.controller.items,
                          children: widget.controller.children,
                          pattern: pattern,
                          sensorType: sensorType,
                          status: status,
                        );

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: width + metadata.depth * 22.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 56.0 + 16.0,
                              ),
                              itemCount: metadata.records.length,
                              itemBuilder: (context, index) {
                                return ItemWidget(
                                  item: metadata.records[index].item,
                                  width: width,
                                  pipes: metadata.records[index].pipes,
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  );
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
