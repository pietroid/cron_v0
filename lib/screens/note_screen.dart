import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_notes/blocs/note_bloc.dart';
import 'package:smart_notes/blocs/note_event.dart';
import 'package:smart_notes/entities/note.dart';
import 'package:smart_notes/utils/note_id_generator.dart';

class NoteScreen extends StatefulWidget {
  final Note? existingNote;
  const NoteScreen({super.key, this.existingNote});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String content = '';
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.existingNote?.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (widget.existingNote != null) {
                  context.read<NoteBloc>().add(
                        NoteDeleted(
                          timestamp: widget.existingNote!.id,
                        ),
                      );
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 20,
          ),
          child: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                content = value;
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a note',
            ),
            maxLines: null,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: content.isEmpty
              ? null
              : () {
                  if (widget.existingNote != null) {
                    context.read<NoteBloc>().add(
                          NoteEdited(
                            content: content,
                            id: widget.existingNote!.id,
                          ),
                        );
                  } else {
                    context.read<NoteBloc>().add(
                          NoteAdded(
                            content: content,
                            id: NoteIdGenerator().generateId(),
                          ),
                        );
                  }
                  Navigator.pop(context);
                },
          child: const Icon(
            Icons.check,
          ),
        ));
  }
}
