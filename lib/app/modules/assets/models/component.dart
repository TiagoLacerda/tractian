import '../../../core/models/item.dart';
import '../enums/sensor_type.dart';
import '../enums/status.dart';

class Component extends Item {
  final String? parentId;
  final String? locationId;
  final String gatewayId;
  final SensorType sensorType;
  final Status status;

  Component({
    required super.id,
    required super.name,
    this.parentId,
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

  @override
  Component.fromMap(Map<String, dynamic> map)
      : parentId = map['parentId'],
        locationId = map['locationId'],
        gatewayId = map['gatewayId'],
        sensorType = SensorType.parse(map['sensorType']),
        status = Status.parse(map['status']),
        super(
          id: map['id'],
          name: map['name'],
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
