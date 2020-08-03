import 'exceptions.dart';

part 'node.dart';

class DoubleLinkedList<E> {
  int _length = 0;
  late final Node<E> begin;
  late final Node<E> end;

  Node<E> get first => begin.next;

  Node<E> get last => end.previous;

  bool get isEmpty => _length == 0;

  bool get isNotEmpty => !isEmpty;

  int get length => _length;

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

  DoubleLinkedList.empty() {
    _initialize();
  }

  DoubleLinkedList.fromIterable(Iterable<E> contents) {
    _initialize();
    Node<E> previousNode = begin;
    for (final element in contents) {
      previousNode = previousNode.insertAfter(element);
    }
  }

  DoubleLinkedList.from(DoubleLinkedList<E> from) : this.fromIterable(from.content);

  DoubleLinkedList<E> copy() => DoubleLinkedList.from(this);

  DoubleLinkedList<T> map<T>(T Function(E element) transform) => DoubleLinkedList.fromIterable(content.map(transform));

  void forEach(void Function(E element) function) => content.forEach(function);

  void apply(E Function(E element) transform) {
    for (var node = first; node != end; node = node.next) {
      node._content = transform(node.content);
    }
  }

  DoubleLinkedList<E> where<T>(bool Function(E element) test) => DoubleLinkedList.fromIterable(content.where(test));

  bool contains(E element) => content.contains(element);

  E reduce(E Function(E value, E element) combine) {
    if (isEmpty) throw LinkedListException.noElement();
    return content.reduce(combine);
  }

  T fold<T>(T initialValue, T Function(T value, E element) combine) => content.fold(initialValue, combine);

  List<E> toList() => content.toList();

  Set<E> toSet() => content.toSet();

  bool any(bool Function(E element) test) => content.any(test);

  bool every(bool Function(E element) test) => content.every(test);

  Node<E> firstWhere(bool Function(E element) test, {bool orEnd = false}) {
    for (var node = first; node != end; node = node.next) {
      if (test(node.content)) return node;
    }
    if (orEnd) return end;
    throw LinkedListException.noElement();
  }

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
