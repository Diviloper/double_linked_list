import 'package:double_linked_list/double_linked_list.dart';
import 'package:test/test.dart';

void main() {
  group('constructors', () {
    test('empty constructor creates an empty linked list', () {
      final list = DoubleLinkedList.empty();
      expect(list.isEmpty, isTrue);
    });

    test('content constructor creates a linked list with passed contents', () {
      final list = DoubleLinkedList.fromIterable([1, 2, 3, 4, 5]);
      expect(list.isNotEmpty, isTrue);
      expect(list.length, 5);
      var node = list.first;
      for (var i = 1; i <= 5; ++i, node = node.next) {
        expect(node.content, i);
      }
    });

    test('from constructor creates a copy of the passed linked list', () {
      final originalList = DoubleLinkedList.fromIterable([1, 2, 3]);
      final copyList = DoubleLinkedList.from(originalList);
      expect(copyList.content, originalList.content);
      expect(copyList.first, isNot(originalList.first));
    });
  });

  group('getters', () {
    DoubleLinkedList<int> list;
    DoubleLinkedList<int> emptyList;

    setUp(() {
      list = DoubleLinkedList.fromIterable([1, 2, 3, 4, 5]);
      emptyList = DoubleLinkedList.empty();
    });

    group('first', () {
      test('returns first content node', () {
        final node = list.first;
        expect(node.isFirst, isTrue);
        expect(node.content, 1);
      });

      test('returns end node when list is empty', () {
        expect(emptyList.first, emptyList.end);
      });
    });

    group('last', () {
      test('returns last content node', () {
        final node = list.last;
        expect(node.isLast, isTrue);
        expect(node.content, 5);
      });

      test('return begin node when list is empty', () {
        expect(emptyList.last, emptyList.begin);
      });
    });

    test('content returns iterable with list contents', () {
      final contents = list.content;
      expect(contents, isA<Iterable<int>>());
      expect(contents, orderedEquals([1, 2, 3, 4, 5]));

      expect(DoubleLinkedList.empty().content, Iterable.empty());
    });
  });

  group('methods', () {
    DoubleLinkedList<int> list;

    setUp(() {
      list = DoubleLinkedList.fromIterable([1, 2, 3, 4, 5]);
    });

    test('toList returns list with list contents', () {
      final contents = list.toList();
      expect(contents, isA<List<int>>());
      expect(contents, orderedEquals([1, 2, 3, 4, 5]));
    });

    test('toSet returns set with list contents', () {
      final contents = list.toSet();
      expect(contents, isA<Set<int>>());
      expect(contents, {1, 2, 3, 4, 5});
    });

    test('map returns a new linked list with mapped content', () {
      final mappedList = list.map((i) => i * 2);
      expect(mappedList.content, [2, 4, 6, 8, 10]);
    });

    test('forEach calls function passed once for each item', () {
      final called = <int>[];
      list.forEach((int i) => called.add(i));
      expect(called, [1, 2, 3, 4, 5]);
    });

    test('apply transforms list by apllying the function passed to every item',
        () {
      list.apply((i) => i * 2);
      expect(list.content, [2, 4, 6, 8, 10]);
    });

    test('where returns a new linked list with elements that passed function',
        () {
      final filteredList = list.where((e) => e.isEven);
      expect(filteredList.content, [2, 4]);
    });

    test('any returns whether any element satisfies test', () {
      expect(list.any((e) => e > 2), isTrue);
      expect(list.any((e) => e > 10), isFalse);
    });

    test('every returns whether every element satisfies test', () {
      expect(list.every((e) => e > 0), isTrue);
      expect(list.every((e) => e > 1), isFalse);
    });

    group('firstWhere', () {
      test('returns node containing the first element that satisfies test', () {
        final node = list.first.next.next;
        expect(list.firstWhere((e) => e > 2), node);
      });

      test('throws exception when no element satisfies test', () {
        expect(() => list.firstWhere((e) => e < 0),
            throwsA(LinkedListException.noElement()));
      });

      test(
          'returns end node when no element satisfies test and orEnd is set to true',
          () {
        expect(list.firstWhere((e) => e < 0, orEnd: true), list.end);
      });
    });

    group('lastWhere', () {
      test('returns node containing the last element that satisfies test', () {
        final node = list.last.previous.previous;
        expect(list.lastWhere((e) => e < 4), node);
      });

      test('throws exception when no element satisfies test', () {
        expect(() => list.lastWhere((e) => e < 0),
            throwsA(LinkedListException.noElement()));
      });

      test(
          'returns begin node when no element satisfies test and orBegin is set to true',
          () {
        expect(list.lastWhere((e) => e < 0, orBegin: true), list.begin);
      });
    });
  });
}
