import 'package:double_linked_list/double_linked_list.dart';

//ignore_for_file: unused_local_variable
//ignore_for_file: omit_local_variable_types

void main() {
  final list = DoubleLinkedList.fromIterable([1, 2, 3]);
  //Empty
  final emptyList = DoubleLinkedList.empty();
  print(emptyList.length); // 0

  // From Iterables
  final fromList = DoubleLinkedList.fromIterable([1, 2, 3]);
  print(fromList.length); // 3
  print(fromList); // [1 | 2 | 3]

  final fromSet = DoubleLinkedList.fromIterable({1, 2, 3});
  print(fromSet.length); // 3
  print(fromSet); // [1 | 2 | 3]

  // With extension methods
  final fromListExtension = [1, 2, 3].toDoubleLinkedList();
  print(fromListExtension); // [1 | 2 | 3]

  final fromSetExtension = {1, 2, 3}.toDoubleLinkedList();
  print(fromSetExtension); // [1 | 2 | 3]

  // To iterables
  final Iterable<int> toIterable = list.content;
  final List<int> toList = list.toList();
  final Set<int> toSet = list.toSet();

  // From other DoubleLinkedLists
  final copy = DoubleLinkedList.from(fromList);
  final copy2 = fromList.copy();
  print(copy); // [1 | 2 | 3]
  print(copy == fromList); // false

  // Copy constructors perform shallow copy
  final originalList = [Object(), Object()];
  final firstLinkedList = DoubleLinkedList.fromIterable(originalList);
  final copyLinkedList = DoubleLinkedList.from(firstLinkedList);

  print(originalList.first == firstLinkedList.first.content); // true
  print(firstLinkedList.first.content == copyLinkedList.first.content); // true

  // New nodes are created in the list copy
  print(firstLinkedList.first == copyLinkedList.first); // false

  // Iteration
  for (var node = list.first; !node.isEnd; node = node.next) {
    print(node);
  }
  // (1)
  // (2)
  // (3)

  // Reverse iteration
  for (var node = list.last; !node.isBegin; node = node.previous) {
    print(node);
  }
  // (3)
  // (2)
  // (1)

  // Insertion
  var listCopy = list.copy();
  listCopy.begin.insertAfter(0);
  print(listCopy); // [0 | 1 | 2 | 3]

  listCopy = list.copy();
  for (var node = listCopy.first; !node.isEnd; node = node.next) {
    node.insertBefore(-1);
  }
  print(listCopy); // [-1 | 1 | -1 | 2 | -1 | 3]

  listCopy = list.copy();
  for (var node = listCopy.begin; !node.isEnd; node = node.next) {
    node = node.insertAfter(0);
  }
  print(listCopy); // [0 | 1 | 0 | 2 | 0 | 3 | 0]

  // ForEach
  list.forEach(print);
  // 1
  // 2
  // 3

  // Apply
  list.apply((e) => e * e);
  print(list); // [1 | 4 | 9]

  // Where
  print(list.where((e) => e.isOdd)); // [1 | 9]

  // Reduce
  print(list.reduce((value, element) => value + element)); // 14

  // Fold
  print(list.fold<int>(-14, (value, element) => value + element)); // 0

  // Any
  print(list.any((e) => e > 2)); // true

  // Every
  print(list.every((e) => e > 2)); // false

  // FirstWhere
  print(list.firstWhere((e) => e > 2)); // (4)

  // LastWhere
  print(list.lastWhere((e) => e > 2)); // (9)
}
