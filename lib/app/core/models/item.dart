import 'dart:convert';

class Item {
  final String id;
  final String name;
  bool collapsed;

  Item({
    required this.id,
    required this.name,
    this.collapsed = false,
  });

  Item copy() => Item(
        id: id,
        name: name,
      );

  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        collapsed = map['collapsed'] ?? false;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'collapsed': collapsed,
      };

  @override
  String toString() => jsonEncode(toMap());
}
