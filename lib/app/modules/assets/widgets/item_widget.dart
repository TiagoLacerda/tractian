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
import '../models/metadata.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final double width;
  final List<Pipe> pipes;
  final void Function()? onTap;

  const ItemWidget({
    super.key,
    required this.item,
    required this.width,
    required this.pipes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon;

    Widget? suffix;

    if (item is Location) {
      icon = SvgPicture.asset(
        AppIcons.location,
      );
    } else if (item is Asset) {
      icon = SvgPicture.asset(
        AppIcons.asset,
      );
    } else if (item is Component) {
      icon = SvgPicture.asset(
        AppIcons.component,
      );

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
    } else {
      throw Exception(
        'Tried to layout an Item that is neither a Location, Asset or Component.',
      );
    }

    final leading = pipes.map((pipe) {
      return CustomPaint(
        painter: PipePainter(pipe),
        size: const Size.square(22.0),
      );
    });

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: max(width, width / 2.0 + pipes.length * 22.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...leading,
              if (item is Component) ...[
                const CustomPaint(
                  painter: PipePainter(Pipe.horizontal),
                  size: Size.square(22.0),
                )
              ] else ...[
                Transform.rotate(
                  angle: item.collapsed ? -pi * 0.5 : pi * 0.5,
                  child: const Icon(
                    Icons.chevron_right_outlined,
                    size: 22.0,
                  ),
                ),
              ],
              icon,
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
        ),
      ),
    );
  }
}

class PipePainter extends CustomPainter {
  final Pipe pipe;

  const PipePainter(
    this.pipe,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    switch (pipe) {
      case Pipe.none:
        break;
      case Pipe.vertical:
        canvas.drawLine(
          Offset(size.width / 2.0, 0.0),
          Offset(size.width / 2.0, size.height),
          paint,
        );
        break;
      case Pipe.bend:
        canvas.drawLine(
          Offset(size.width / 2.0, 0.0),
          Offset(size.width / 2.0, size.height / 2.0),
          paint,
        );
        canvas.drawLine(
          Offset(size.width / 2.0, size.height / 2.0),
          Offset(size.width, size.height / 2.0),
          paint,
        );
        break;
      case Pipe.junction:
        canvas.drawLine(
          Offset(size.width / 2.0, 0.0),
          Offset(size.width / 2.0, size.height),
          paint,
        );
        canvas.drawLine(
          Offset(size.width / 2.0, size.height / 2.0),
          Offset(size.width, size.height / 2.0),
          paint,
        );
        break;
      case Pipe.horizontal:
        canvas.drawLine(
          Offset(0.0, size.height / 2.0),
          Offset(size.width / 2.0, size.height / 2.0),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
