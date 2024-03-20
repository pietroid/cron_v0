import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_notes/entities/note.dart';

@immutable
class NoteState extends Equatable {
  final List<Note> notes;

  const NoteState({required this.notes});

  @override
  List<Object> get props => [notes];
}
