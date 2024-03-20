import 'package:equatable/equatable.dart';

class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteAdded extends NoteEvent {
  final String content;
  final int id;

  const NoteAdded({
    required this.content,
    required this.id,
  });

  @override
  List<Object> get props => [content];
}

class NoteEdited extends NoteEvent {
  final String content;
  final int id;

  const NoteEdited({
    required this.content,
    required this.id,
  });

  @override
  List<Object> get props => [content, id];
}

class NoteDeleted extends NoteEvent {
  final int timestamp;

  const NoteDeleted({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}
