import 'package:double_linked_list/double_linked_list.dart';

extension IterableToDoubleLinkedList<T> on Iterable<T> {
  DoubleLinkedList<T> toDoubleLinkedList() => DoubleLinkedList.fromIterable(this);
}