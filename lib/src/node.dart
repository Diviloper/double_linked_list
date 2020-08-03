part of 'double_linked_list.dart';

class Node<T> {
  final DoubleLinkedList<T> list;
  T? _content;
  late Node<T> _previous;
  late Node<T> _next;
  final bool _isEnd;

  Node<T> get previous => _previous;

  Node<T> get next => _next;

  T get content {
    if (_isEnd) throw LinkedListException.endNoContent();
    return _content as T;
  }

  bool get isBegin => _previous == this;

  bool get isEnd => _next == this;

  bool get isFirst => !isBegin && _previous == list.begin;

  bool get isLast => !isEnd && _next == list.end;

  Node<T> insertBefore(T element) {
    if (isBegin) throw LinkedListException.cannotInsertBeforeBegin();
    final newNode = Node._(list, element, previous: _previous, next: this);
    _previous._next = newNode;
    _previous = newNode;
    list._length++;
    return newNode;
  }

  Node<T> insertAfter(T element) {
    if (isEnd) throw LinkedListException.cannotInsertAfterEnd();
    final newNode = Node._(list, element, previous: this, next: _next);
    _next._previous = newNode;
    _next = newNode;
    list._length++;
    return newNode;
  }

  Node<T> remove() {
    if (_isEnd) throw LinkedListException.cannotRemoveEnd();
    _next._previous = _previous;
    _previous._next = _next;
    list._length--;
    return next;
  }

  Node._(this.list, this._content, {Node<T>? previous, Node<T>? next}) : _isEnd = false {
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