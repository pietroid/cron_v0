import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/blocs/note_bloc.dart';
import 'package:smart_notes/blocs/note_state.dart';
import 'package:smart_notes/screens/note_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            //Navigate to note screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NoteScreen()),
            );
          }),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) => Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.notes[index].content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteScreen(
                          existingNote: state.notes[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
