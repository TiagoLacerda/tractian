class Node<T> {
  final T value;
  final List<Node<T>> children;

  const Node({
    required this.value,
    required this.children,
  });

  @override
  String toString() => '{"value": $value, "children":[$children]}';
}
