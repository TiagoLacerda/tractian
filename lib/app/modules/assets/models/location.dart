import '../../../core/models/item.dart';

class Location extends Item {
  final String? parentId;

  Location({
    required super.id,
    required super.name,
    this.parentId,
  });

  @override
  Location copy() => Location(
        id: id,
        name: name,
        parentId: parentId,
      );

  @override
  Location.fromMap(Map<String, dynamic> map)
      : parentId = map['parentId'],
        super(
          id: map['id'],
          name: map['name'],
        );
}
