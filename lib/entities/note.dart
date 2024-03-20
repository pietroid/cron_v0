import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
@immutable
class Note extends Equatable {
  final int id;
  final String content;

  const Note({
    required this.id,
    required this.content,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

  Note copyWith({
    int? id,
    String? content,
  }) {
    return Note(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  @override
  List<Object> get props => [id, content];
}
