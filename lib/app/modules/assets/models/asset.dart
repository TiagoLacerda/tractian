import '../../../core/models/item.dart';

class Asset extends Item {
  final String? parentId;
  final String? locationId;

  Asset({
    required super.id,
    required super.name,
    this.parentId,
    this.locationId,
  });

  @override
  Asset copy() => Asset(
        id: id,
        name: name,
        parentId: parentId,
        locationId: locationId,
      );

  Asset.fromMap(Map<String, dynamic> map)
      : parentId = map['parentId'],
        locationId = map['locationId'],
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
      };
}
