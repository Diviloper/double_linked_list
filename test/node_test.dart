import 'package:double_linked_list/double_linked_list.dart';
import 'package:test/test.dart';

void main() {
  late DoubleLinkedList<int> list;

  setUp(() {
    list = DoubleLinkedList.fromIterable([2, 3, 4]);
  });

  group('isFirst', () {
    test('returns true when is first content node of a list', () {
      expect(list.first.isFirst, isTrue);
    });

    test('returns false when is not first content node of a list', () {
      expect(list.last.isFirst, isFalse);
      expect(list.first.next.isFirst, isFalse);
    });

    test('returns false when is an end/begin node', () {
      expect(list.begin.isFirst, isFalse);
      expect(list.end.isFirst, isFalse);
    });
  });

  group('isLast', () {
    test('returns true when is last content node of a list', () {
      expect(list.last.isLast, isTrue);
    });

    test('returns false when is not last content node of a list', () {
      expect(list.first.isLast, isFalse);
      expect(list.last.previous.isLast, isFalse);
    });

    test('returns false when is an end/begin node', () {
      expect(list.begin.isLast, isFalse);
      expect(list.end.isLast, isFalse);
    });
  });

  group('isBegin', () {
    test('returns true when is begin node', () {
      expect(list.begin.isBegin, isTrue);
    });

    test('returns false when is content node', () {
      expect(list.first.isBegin, isFalse);
      expect(list.first.next.isBegin, isFalse);
    });

    test('returns false when is end node', () {
      expect(list.end.isBegin, isFalse);
    });
  });

  group('isEnd', () {
    test('returns true when is end node', () {
      expect(list.end.isEnd, isTrue);
    });

    test('returns false when is content node', () {
      expect(list.last.isEnd, isFalse);
      expect(list.last.previous.isEnd, isFalse);
    });

    test('returns false when is begin node', () {
      expect(list.begin.isEnd, isFalse);
    });
  });

  group('content', () {
    test('returns content value in normal nodes', () {
      expect(list.first.content, 2);
    });

    test('throws exception when called on begin node', () {
      expect(() => list.begin.content,
          throwsA(LinkedListException.endNoContent()));
    });

    test('throws exception when called on end node', () {
      expect(
          () => list.end.content, throwsA(LinkedListException.endNoContent()));
    });
  });

  group('insertBefore', () {
    test('increments list size', () {
      expect(list.length, 3);
      list.first.insertBefore(1);
      expect(list.length, 4);
    });

    test('inserts element before node', () {
      expect(list.toList(), [2, 3, 4]);
      list.first.insertBefore(1);
      expect(list.toList(), [1, 2, 3, 4]);
    });

    test('returns inserted node', () {
      final node = list.first;
      final newNode = node.insertBefore(1);
      expect(newNode.next, node);
    });

    test('updates first node properly', () {
      final firstNode = list.first;
      final newNode = firstNode.insertBefore(1);
      expect(firstNode.isFirst, isFalse);
      expect(newNode.isFirst, isTrue);
      expect(list.first, newNode);
    });

    test('updates links properly', () {
      var node = list.begin.next;
      for (int i = 2; i <= 4; ++i, node = node.next) {
        expect(node.content, i);
      }
      node = list.end.previous;
      for (int i = 4; i >= 2; --i, node = node.previous) {
        expect(node.content, i);
      }

      list.first.insertBefore(1);

      node = list.begin.next;
      for (int i = 1; i <= 4; ++i, node = node.next) {
        expect(node.content, i);
      }
      node = list.end.previous;
      for (int i = 4; i >= 1; --i, node = node.previous) {
        expect(node.content, i);
      }
    });

    test('throws exception when called on a begin node', () {
      expect(() => list.begin.insertBefore(1),
          throwsA(LinkedListException.cannotInsertBeforeBegin()));
      expect(list.length, 3);
    });
  });

  group('insertAfter', () {
    test('increments list size', () {
      expect(list.length, 3);
      list.last.insertAfter(5);
      expect(list.length, 4);
    });

    test('inserts element after node', () {
      expect(list.toList(), [2, 3, 4]);
      list.last.insertAfter(5);
      expect(list.toList(), [2, 3, 4, 5]);
    });

    test('returns inserted node', () {
      final node = list.last;
      final newNode = node.insertAfter(5);
      expect(newNode.previous, node);
    });

    test('updates last node properly', () {
      final lastNode = list.last;
      final newNode = lastNode.insertAfter(5);
      expect(lastNode.isLast, isFalse);
      expect(newNode.isLast, isTrue);
      expect(list.last, newNode);
    });

    test('updates links properly', () {
      var node = list.begin.next;
      for (int i = 2; i <= 4; ++i, node = node.next) {
        expect(node.content, i);
      }
      node = list.end.previous;
      for (int i = 4; i >= 2; --i, node = node.previous) {
        expect(node.content, i);
      }

      list.last.insertAfter(5);

      node = list.begin.next;
      for (int i = 2; i <= 5; ++i, node = node.next) {
        expect(node.content, i);
      }
      node = list.end.previous;
      for (int i = 5; i >= 2; --i, node = node.previous) {
        expect(node.content, i);
      }
    });

    test('throws exception when called on an end node', () {
      expect(() => list.end.insertAfter(5),
          throwsA(LinkedListException.cannotInsertAfterEnd()));
      expect(list.length, 3);
    });
  });

  group('remove', () {
    test('decrements list size', () {
      expect(list.length, 3);
      list.first.remove();
      expect(list.length, 2);
    });

    test('removes element', () {
      expect(list.toList(), [2, 3, 4]);
      list.first.remove();
      expect(list.toList(), [3, 4]);
    });

    test('returns next node', () {
      var next = list.first.next;
      expect(list.first.remove(), next);
      expect(list.last.remove(), list.end);
    });

    test('updates links properly', () {
      var node = list.begin.next;
      for (int i = 2; i <= 4; ++i, node = node.next) {
        expect(node.content, i);
      }
      node = list.end.previous;
      for (int i = 4; i >= 2; --i, node = node.previous) {
        expect(node.content, i);
      }

      list.first.remove();

      node = list.begin.next;
      for (int i = 3; i <= 4; ++i, node = node.next) {
        expect(node.content, i);
      }
      node = list.end.previous;
      for (int i = 4; i >= 3; --i, node = node.previous) {
        expect(node.content, i);
      }
    });

    test('throws an exception when called on begin or end node', () {
      expect(() => list.begin.remove(),
          throwsA(LinkedListException.cannotRemoveEnd()));
      expect(list.length, 3);
      expect(() => list.end.remove(),
          throwsA(LinkedListException.cannotRemoveEnd()));
      expect(list.length, 3);
    });
  });
}
