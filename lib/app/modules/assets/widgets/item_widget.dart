import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_icons.dart';
import '../enums/sensor_type.dart';
import '../enums/status.dart';
import '../models/asset.dart';
import '../models/component.dart';
import '../models/item.dart';
import '../models/location.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final double width;
  final List<bool> shouldDrawLine;

  const ItemWidget({
    super.key,
    required this.item,
    required this.width,
    required this.shouldDrawLine,
  });

  @override
  Widget build(BuildContext context) {
    String icon;

    if (item is Location) {
      icon = AppIcons.location;
    } else if (item is Asset) {
      icon = AppIcons.asset;
    } else if (item is Component) {
      icon = AppIcons.component;
    } else {
      throw Exception(
        'Tried to layout an Item that is neither a Location, Asset or Component.',
      );
    }

    Widget? suffix;

    if (item is Component) {
      final component = item as Component;

      Color color;

      switch (component.status) {
        case Status.operating:
          color = Colors.green;
          break;
        case Status.alert:
          color = Colors.red;
          break;
      }

      switch (component.sensorType) {
        case SensorType.energy:
          suffix = Icon(
            Icons.bolt_outlined,
            color: color,
            size: 16.0,
          );
          break;
        case SensorType.vibration:
          suffix = Icon(
            Icons.circle,
            color: color,
            size: 12.0,
          );
          break;
      }
    }

    return SizedBox(
      width: width + shouldDrawLine.length * 22.0,
      child: Row(
        children: [
          for (var boolean in shouldDrawLine) ...[
            if (boolean)
              Container(
                width: 1.0,
                height: 24.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.5,
                ),
                color: Colors.black.withOpacity(0.2),
              )
            else
              const SizedBox(
                height: 24.0,
                width: 22.0,
              ),
          ],
          Transform.rotate(
            angle: pi * 0.5,
            child: const Icon(
              Icons.chevron_right_outlined,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 4.0),
          SvgPicture.asset(
            icon,
          ),
          const SizedBox(width: 4.0),
          Flexible(
            child: Text(
              item.name,
            ),
          ),
          if (suffix != null) ...[
            const SizedBox(width: 4.0),
            suffix,
          ],
        ],
      ),
    );
  }
}
