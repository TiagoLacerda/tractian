import 'item.dart';

class Company extends Item {
  Company({
    required super.id,
    required super.name,
    super.collapsed,
  });

  @override
  Company.fromMap(Map<String, dynamic> map)
      : super(
          id: map['id'],
          name: map['name'],
          collapsed: map['collapsed'] ?? false,
        );
}
