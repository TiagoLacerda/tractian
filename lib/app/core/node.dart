import 'dart:math';

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

  /// Calls [compare] between [this] and [other], then does the same between the
  /// children of [this] and [other], up to the nth child, where n is 
  /// `min(this.children.length, other.children.length)`.
  /// 
  /// This may be used in a best-effort approach to keep some lingering data
  /// between refreshes (such as whether items are collapsed or not).
  void foo(Node<T> other, void Function(Node<T> a, Node<T> b) compare) {
    compare(this, other);

    for (int i = 0; i < min(this.children.length, other.children.length); i++) {
      this.children[i].foo(other.children[i], compare);
    }
  }
}
