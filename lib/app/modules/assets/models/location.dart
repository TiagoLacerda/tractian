import 'item.dart';

class Location extends Item {
  Location({
    required super.id,
    required super.name,
    super.parentId,
  });

  Location.fromMap(super.map) : super.fromMap();
}
