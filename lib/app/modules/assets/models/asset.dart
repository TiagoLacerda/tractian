import 'item.dart';

class Asset extends Item {
  final String? locationId;

  Asset({
    required super.id,
    required super.name,
    super.parentId,
    this.locationId,
  }) : assert(!(parentId == null && locationId == null));

  Asset.fromMap(Map<String, dynamic> map)
      : locationId = map['locationId'],
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
      };
}
