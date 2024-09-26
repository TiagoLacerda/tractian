class Node<T extends Object?> {
  final T value;
  final Node<T>? parent;
  final List<Node<T>> children;

  const Node({
    required this.value,
    this.parent,
    required this.children,
  });

  Node<T> copy(T Function(T) copyFunction) {
    return Node(
      value: copyFunction(this.value),
      parent: this.parent?.copy(copyFunction),
      children: children.map((child) => child.copy(copyFunction)).toList(),
    );
  }
}
