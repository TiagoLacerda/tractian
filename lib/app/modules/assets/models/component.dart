import '../enums/sensor_type.dart';
import '../enums/status.dart';
import 'item.dart';

class Component extends Item {
  final String? locationId;
  final String gatewayId;
  final SensorType sensorType;
  final Status status;

  Component({
    required super.id,
    required super.name,
    super.parentId,
    this.locationId,
    required this.gatewayId,
    required this.sensorType,
    required this.status,
  });

  @override
  Component copy() => Component(
        id: id,
        name: name,
        parentId: parentId,
        locationId: locationId,
        gatewayId: gatewayId,
        sensorType: sensorType,
        status: status,
      );

  Component.fromMap(Map<String, dynamic> map)
      : locationId = map['locationId'],
        gatewayId = map['gatewayId'],
        sensorType = SensorType.parse(map['sensorType']),
        status = Status.parse(map['status']),
        super(
          id: map['id'],
          name: map['name'],
          parentId: map['parentId'],
        );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'parentId': parentId,
        'locationId': locationId,
        'gatewayId': gatewayId,
        'sensorType': sensorType.toString(),
        'status': status.toString(),
      };
}
