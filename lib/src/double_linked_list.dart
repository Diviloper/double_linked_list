import 'exceptions.dart';

part 'node.dart';

/// Generic double-linked list data structure
class DoubleLinkedList<E> {
  int _length = 0;
  late final Node<E> begin;
  late final Node<E> end;

  /// Get the first inner node of [this].
  /// If [this] is empty, then returns the [end] node.
  Node<E> get first => begin.next;

  /// Get the last inner node of [this].
  /// If [this] is empty, then returns the [begin] node.
  Node<E> get last => end.previous;

  /// Whether [this] is empty.
  bool get isEmpty => _length == 0;

  /// Whether [this] is not empty.
  bool get isNotEmpty => !isEmpty;

  /// Get the number of elements in [this].
  int get length => _length;

  /// Get a lazy iterable with all the elements in [this].
  Iterable<E> get content sync* {
    for (var node = first; node != end; node = node.next) {
      yield node.content;
    }
  }

  void _initialize() {
    _length = 0;
    begin = Node._begin(this);
    end = Node._end(this);
    begin._next = end;
    end._previous = begin;
  }

  /// Creates an empty [DoubleLinkedList]
  DoubleLinkedList.empty() {
    _initialize();
  }

  /// Creates a new [DoubleLinkedList] with the contents of the passed [Iterable].
  /// Note that this does not perform a deep copy.
  DoubleLinkedList.fromIterable(Iterable<E> contents) {
    _initialize();
    Node<E> previousNode = begin;
    for (final element in contents) {
      previousNode = previousNode.insertAfter(element);
    }
  }

  /// Creates a new [DoubleLinkedList] with the contents of the passed [DoubleLinkedList].
  /// Note that this does not perform a deep copy.
  DoubleLinkedList.from(DoubleLinkedList<E> from) : this.fromIterable(from.content);

  /// Creates a new [DoubleLinkedList] with the contents of [this].
  /// Note that this does not perform a deep copy.
  DoubleLinkedList<E> copy() => DoubleLinkedList.from(this);

  /// Creates a new [DoubleLinkedList] with the contents of the [this], applying [transform] to each element.
  /// Note that this does not perform a deep copy.
  /// For an in-place transformation, see [DoubleLinkedList.apply].
  DoubleLinkedList<T> map<T>(T Function(E element) transform) => DoubleLinkedList.fromIterable(content.map(transform));

  /// Calls [function] with each element of [this].
  void forEach(void Function(E element) function) => content.forEach(function);

  /// Transforms each element of [this] by applying [transform] to each of them.
  /// For an out-of-place transformation, see [DoubleLinkedList.map].
  void apply(E Function(E element) transform) {
    for (var node = first; node != end; node = node.next) {
      node._content = transform(node.content);
    }
  }

  /// Returns a new [DoubleLinkedList] with only the elements of [this] that satisfy [test].
  DoubleLinkedList<E> where<T>(bool Function(E element) test) => DoubleLinkedList.fromIterable(content.where(test));

  /// Checks whether [this] contains [element].
  bool contains(E element) => content.contains(element);

  /// Reduces [this] to a single value by iteratively combining its elements using [combine].
  /// If [this] is empty, then a [LinkedListException.noElement] is thrown.
  /// If [this] has only one element, it is returned.
  E reduce(E Function(E value, E element) combine) {
    if (isEmpty) throw LinkedListException.noElement();
    return content.reduce(combine);
  }

  /// Reduces [this] to a single value by iteratively combining each element with an existing value.
  /// Uses [initialValue] as the initial value, then iterates through the
  /// elements and updates the value with each element using the [combine] function.
  T fold<T>(T initialValue, T Function(T value, E element) combine) => content.fold(initialValue, combine);

  /// Returns a [List] with the contents of [this]
  List<E> toList() => content.toList();

  /// Returns a [Set] with the contents of [this]
  Set<E> toSet() => content.toSet();

  /// Checks whether any element in [this] satisfies [test]
  bool any(bool Function(E element) test) => content.any(test);

  /// Checks whether every element in [this] satisfies [test]
  bool every(bool Function(E element) test) => content.every(test);

  /// Returns the first [Node] whose value satisfies [test].
  Node<E> firstWhere(bool Function(E element) test, {bool orEnd = false}) {
  /// If no such element exists, it throws [LinkedListException.noElement] if [orEnd] is false, or [end] otherwise.

  /// Returns the first [Node] whose value satisfies [test].
  /// If no such element exists, it throws [LinkedListException.noElement] if [orEnd] is false, or [end] otherwise.
    for (var node = first; node != end; node = node.next) {
      if (test(node.content)) return node;
    }
    if (orEnd) return end;
    throw LinkedListException.noElement();
  }

  /// Returns the last [Node] whose value satisfies [test].
  /// If no such element exists, it throws [LinkedListException.noElement] if [orBegin] is false, or [begin] otherwise.
  Node<E> lastWhere(bool Function(E element) test, {bool orBegin = false}) {
    for (var node = last; node != begin; node = node.previous) {
      if (test(node.content)) return node;
    }
    if (orBegin) return begin;
    throw LinkedListException.noElement();
  }

  @override
  String toString() => '[${content.join(' | ')}]';
}
