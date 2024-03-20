import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_notes/blocs/note_event.dart';
import 'package:smart_notes/blocs/note_state.dart';
import 'package:smart_notes/entities/note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> with HydratedMixin {
  NoteBloc() : super(const NoteState(notes: [])) {
    hydrate();
    on<NoteAdded>(_onNoteAdded);
    on<NoteEdited>(_onNoteEdited);
    on<NoteDeleted>(_onNoteDeleted);
  }

  @override
  NoteState fromJson(Map<String, dynamic> json) => NoteState(
        notes: (json['notes'] as List?)
                ?.map((note) => Note.fromJson(note))
                .toList() ??
            [],
      );

  @override
  Map<String, dynamic> toJson(NoteState state) =>
      {'notes': state.notes.map((note) => note.toJson()).toList()};

  void _onNoteAdded(NoteAdded event, Emitter<NoteState> emit) {
    final newNote = Note(
      id: event.id,
      content: event.content,
    );
    final newNotes = [...state.notes, newNote];
    emit(NoteState(
      notes: newNotes,
    ));
  }

  void _onNoteEdited(NoteEdited event, Emitter<NoteState> emit) {
    final editedNotes = state.notes.map((note) {
      if (note.id == event.id) {
        return note.copyWith(content: event.content);
      }
      return note;
    }).toList();
    emit(NoteState(notes: editedNotes));
  }

  void _onNoteDeleted(NoteDeleted event, Emitter<NoteState> emit) {
    final deletedNotes =
        state.notes.where((note) => note.id != event.timestamp).toList();
    emit(NoteState(notes: deletedNotes));
  }
}
