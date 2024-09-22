import 'dart:convert';

class Item {
  final String id;
  final String name;
  final String? parentId;

  Item({
    required this.id,
    required this.name,
    this.parentId,
  });

  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        parentId = map['parentId'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'parentId': parentId,
      };

  @override
  String toString() => jsonEncode(toMap());
}
