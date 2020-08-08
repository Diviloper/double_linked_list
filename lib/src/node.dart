part of 'double_linked_list.dart';

/// Represents the elements that make up the [DoubleLinkedList].
/// A [Node] can be either an *end* node, i.e. virtual nodes at the beginning and end of the [DoubleLinkedList]
/// that don't contain any value, or an *inner* node, that do contain a value.
class Node<T> {
  /// Reference to the [DoubleLinkedList] this [Node] belongs to
  final DoubleLinkedList<T> list;
  T _content;
  Node<T> _previous;
  Node<T> _next;
  final bool _isEnd;

  /// Reference to the previous [Node] in the [DoubleLinkedList]
  Node<T> get previous => _previous;

  /// Reference to the next [Node] in the [DoubleLinkedList]
  Node<T> get next => _next;

  /// Value of the [Node], if [this] is an *end* node (i.e. the begin or end node),
  /// calling [content] throws an [LinkedListException.endNoContent]
  T get content {
    if (_isEnd) throw LinkedListException.endNoContent();
    return _content;
  }

  /// Whether [this] is the begin node
  bool get isBegin => _previous == this;

  /// Whether [this] is the end node
  bool get isEnd => _next == this;

  /// Whether [this] is the first node
  bool get isFirst => !isBegin && _previous == list.begin;

  /// Whether [this] is the last node
  bool get isLast => !isEnd && _next == list.end;

  /// Creates a new [Node] containing the value [element] right before [this] in [list]
  Node<T> insertBefore(T element) {
    if (isBegin) throw LinkedListException.cannotInsertBeforeBegin();
    final newNode = Node._(list, element, previous: _previous, next: this);
    _previous._next = newNode;
    _previous = newNode;
    list._length++;
    return newNode;
  }

  /// Creates a new [Node] containing the value [element] right after [this] in [list]
  Node<T> insertAfter(T element) {
    if (isEnd) throw LinkedListException.cannotInsertAfterEnd();
    final newNode = Node._(list, element, previous: this, next: _next);
    _next._previous = newNode;
    _next = newNode;
    list._length++;
    return newNode;
  }

  /// Removes [this] from [list]
  Node<T> remove() {
    if (_isEnd) throw LinkedListException.cannotRemoveEnd();
    _next._previous = _previous;
    _previous._next = _next;
    list._length--;
    return next;
  }

  Node._(this.list, this._content, {Node<T> previous, Node<T> next})
      : _isEnd = false {
    _previous = previous ?? this;
    _next = next ?? this;
  }

  Node._end(this.list) : _isEnd = true {
    _next = this;
  }

  Node._begin(this.list) : _isEnd = true {
    _previous = this;
  }

  @override
  String toString() => '($content)';
}
