import 'dart:convert';

class Item {
  final String id;
  final String name;
  final String? parentId;
  bool collapsed;

  Item({
    required this.id,
    required this.name,
    this.parentId,
    this.collapsed = false,
  });

  Item copy() => Item(
        id: id,
        name: name,
        parentId: parentId,
      );

  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        parentId = map['parentId'],
        collapsed = map['collapsed'] ?? false;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'parentId': parentId,
        'collapsed': collapsed,
      };

  @override
  String toString() => jsonEncode(toMap());
}
