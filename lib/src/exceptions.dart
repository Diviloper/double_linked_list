import 'package:double_linked_list/double_linked_list.dart';
import 'package:equatable/equatable.dart';

/// Class that represents any error that can occur while using DoubleLinkedList
class LinkedListException extends Equatable {
  final String message;

  @override
  List<Object> get props => [message];

  LinkedListException._(this.message);

  /// Represents error that occurs when trying to select an element that doesn't exists.
  /// For example, trying to use [DoubleLinkedList.reduce] with an empty list
  LinkedListException.noElement() : this._('No element');

  /// Represents error that occurs when trying to remove a begin or end node
  LinkedListException.cannotRemoveEnd()
      : this._('An end node cannot be removed');

  /// Represents error that occurs when trying to access the content of an end node
  LinkedListException.endNoContent() : this._('End node has no content');

  /// Represents error that occurs when trying to insert a node before the begin node
  LinkedListException.cannotInsertBeforeBegin()
      : this._('A node cannot be inserted before begin node');

  /// Represents error that occurs when trying to insert a node after the end node
  LinkedListException.cannotInsertAfterEnd()
      : this._('A node cannot be inserted after end node');
}
