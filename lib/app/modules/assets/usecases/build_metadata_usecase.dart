import 'dart:math' hide log;

import '../../../core/models/item.dart';
import '../../../core/node.dart';
import '../enums/sensor_type.dart';
import '../enums/status.dart';
import '../models/component.dart';
import '../models/metadata.dart';

abstract class IBuildMetadataUsecase {
  Metadata call({
    required Node<Item> root,
    required Pattern? pattern,
    required SensorType? sensorType,
    required Status? status,
  });
}

class BuildMetadataUsecase implements IBuildMetadataUsecase {
  @override
  Metadata call({
    required Node<Item> root,
    required Pattern? pattern,
    required SensorType? sensorType,
    required Status? status,
  }) {
    final clone = root.copy((e) => e);

    prune(
      node: clone,
      pattern: pattern,
      sensorType: sensorType,
      status: status,
    );

    var records = <Record>[];

    final depth = _inner(node: clone, records: records, pipes: []);

    return (depth: depth, records: records);
  }

  /// Prune the tree, leaving only the items that are supposed to be shown, that
  /// is:
  ///
  /// + If no filter is applied, show all items;
  /// + Otherwise, show only matching items and their ancestors.
  bool prune({
    required Node<Item> node,
    bool ancestorHasPatternMatch = false,
    required Pattern? pattern,
    required SensorType? sensorType,
    required Status? status,
  }) {
    var hasPatternMatch = false;

    if (pattern != null) {
      final name = node.value.name.toLowerCase();
      final search = pattern.toString().toLowerCase();

      if (name.contains(search)) {
        hasPatternMatch = true;
      }
    }

    for (int i = 0; i < node.children.length; i++) {
      final remove = prune(
        node: node.children[i],
        ancestorHasPatternMatch: ancestorHasPatternMatch || hasPatternMatch,
        pattern: pattern,
        sensorType: sensorType,
        status: status,
      );

      if (remove) {
        node.children.removeAt(i);
        i--;
      }
    }

    var include = true;

    if (node.children.isEmpty) {
      if (!ancestorHasPatternMatch) {
        if (pattern != null) {
          final name = node.value.name.toLowerCase();
          final search = pattern.toString().toLowerCase();

          if (!name.contains(search)) {
            include = false;
          }
        }
      }

      if (sensorType != null) {
        if (!(node.value is Component &&
            (node.value as Component).sensorType == sensorType)) {
          include = false;
        }
      }

      if (status != null) {
        if (!(node.value is Component &&
            (node.value as Component).status == status)) {
          include = false;
        }
      }
    }

    if (node.value.collapsed) {
      node.children.clear();
    }

    return !include;
  }

  int _inner({
    required Node<Item> node,
    required List<Record> records,
    required List<Pipe> pipes,
  }) {
    records.add((item: node.value, pipes: pipes));

    int depth = 0;

    for (int i = 0; i < node.children.length; i++) {
      final innerDepth = _inner(
        node: node.children[i],
        records: records,
        pipes: [
          if (pipes.isNotEmpty) ...[
            ...pipes.sublist(0, pipes.length - 1),
            if (pipes.last == Pipe.junction) Pipe.vertical,
            if (pipes.last == Pipe.bend) Pipe.none,
          ],
          i < node.children.length - 1 ? Pipe.junction : Pipe.bend,
        ],
      );

      depth = max(depth, innerDepth);
    }

    depth++;

    return depth;
  }
}
