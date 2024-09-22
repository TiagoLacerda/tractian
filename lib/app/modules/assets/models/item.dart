import '../enums/item_type.dart';
import '../enums/sensor_type.dart';
import '../enums/status.dart';

class Item {
  final String id;
  final String name;
  final ItemType type;
  final SensorType? sensorType;
  final Status? status;
  final List<Item>? items;

  Item({
    required this.id,
    required this.name,
    required this.type,
    this.sensorType,
    this.status,
    this.items,
  }) {
    switch (type) {
      case ItemType.location:
        if (sensorType != null) throw FormatException('', sensorType);
        if (status != null) throw FormatException('', status);
        if (items == null) throw FormatException('', items);
        break;
      case ItemType.asset:
        if (sensorType != null) throw FormatException('', sensorType);
        if (status != null) throw FormatException('', status);
        if (items == null) throw FormatException('', items);
        break;
      case ItemType.component:
        if (sensorType == null) throw FormatException('', sensorType);
        if (status == null) throw FormatException('', status);
        break;
      default:
        break;
    }
  }
}
