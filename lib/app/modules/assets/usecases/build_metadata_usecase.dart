import 'dart:math' hide log;

import '../enums/sensor_type.dart';
import '../enums/status.dart';
import '../models/component.dart';
import '../models/item.dart';
import '../models/metadata.dart';

abstract class IBuildMetadataUsecase {
  Metadata call({
    required Map<String, Item> items,
    required Map<String?, List<String>> children,
    required Pattern? pattern,
    required SensorType? sensorType,
    required Status? status,
  });
}

class BuildMetadataUsecase implements IBuildMetadataUsecase {
  @override
  Metadata call({
    required Map<String, Item> items,
    required Map<String?, List<String>> children,
    required Pattern? pattern,
    required SensorType? sensorType,
    required Status? status,
  }) {
    if (items.isEmpty) {
      return (depth: 0, records: []);
    }

    if (children[null] == null) {
      throw ArgumentError(
        'Impossible to build Metadata without children[null] present.',
      );
    }

    var depth = 0;
    var records = <Record>[];

    final ids = children[null] ?? [];

    for (int i = 0; i < ids.length; i++) {
      final data = _inner(
        // Assumes dataset is sound (all referenced ids are present)
        item: items[ids[i]]!,
        items: items,
        children: children,
        pattern: pattern,
        sensorType: sensorType,
        status: status,
        pipes: [],
        isLastSibling: i == ids.length - 1,
      );

      depth = max(depth, data.depth);

      records.addAll(data.records);
    }

    return (depth: depth, records: records);
  }

  Metadata _inner({
    required Item item,
    required Map<String, Item> items,
    required Map<String?, List<String>> children,
    required Pattern? pattern,
    required SensorType? sensorType,
    required Status? status,
    required List<Pipe> pipes,
    required bool isLastSibling,
  }) {
    var depth = 0;
    var records = <Record>[];

    final ids = children[item.id] ?? [];

    for (int i = 0; i < ids.length; i++) {
      final data = _inner(
        // Assumes dataset is sound (all referenced ids are present)
        item: items[ids[i]]!,
        items: items,
        children: children,
        pattern: pattern,
        sensorType: sensorType,
        status: status,
        pipes: [
          ...pipes,
          Pipe.none,
        ],
        isLastSibling: i == ids.length - 1,
      );

      depth = max(depth, data.depth);

      records.addAll(data.records);
    }

    bool include = true;

    if (records.isEmpty) {
      if (pattern != null) {
        if (!item.name
            .toLowerCase()
            .contains(pattern.toString().toLowerCase())) {
          include = false;
        }
      }

      if (sensorType != null) {
        if (!(item is Component && item.sensorType == sensorType)) {
          include = false;
        }
      }

      if (status != null) {
        if (!(item is Component && item.status == status)) {
          include = false;
        }
      }
    }

    if (include) {
      depth++;

      records.insert(0, (item: item, pipes: pipes));
    }

    return (depth: depth, records: records);
  }
}
