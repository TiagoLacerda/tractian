import 'dart:convert';

class Company {
  final String id;
  final String name;

  const Company({
    required this.id,
    required this.name,
  });

  Company.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() => jsonEncode(toMap());
}
