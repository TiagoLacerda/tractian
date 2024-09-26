import 'item.dart';

class Location extends Item {
  Location({
    required super.id,
    required super.name,
    super.parentId,
  });

  @override
  Location copy() => Location(
        id: id,
        name: name,
        parentId: parentId,
      );

  Location.fromMap(super.map) : super.fromMap();
}
