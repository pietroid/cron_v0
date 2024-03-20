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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final shownIndex = state.notes.length - index - 1;
                return Card(
                  elevation: 3, // Add a shadow effect
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4), // Add margin around the card
                  child: ListTile(
                    title: Text(
                      state.notes[shownIndex].content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteScreen(
                            existingNote: state.notes[shownIndex],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
