import 'package:equatable/equatable.dart';

class LinkedListException extends Equatable {
  final String message;

  @override
  List<Object> get props => [message];

  LinkedListException(this.message);

  LinkedListException.noElement() : this('No element');

  LinkedListException.cannotRemoveEnd() : this('An end node cannot be removed');

  LinkedListException.endNoContent() : this('End node has no content');

  LinkedListException.cannotInsertBeforeBegin() : this('A node cannot be inserted before begin node');

  LinkedListException.cannotInsertAfterEnd() : this('A node cannot be inserted after end node');
}
