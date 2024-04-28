import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/presentation/blocs/activity_bloc.dart';
import 'package:smart_activities/presentation/blocs/activity_event.dart';

class ActivityScreen extends StatefulWidget {
  final Activity? existingActivity;
  const ActivityScreen({super.key, this.existingActivity});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String content = '';
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.existingActivity?.content);
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
                if (widget.existingActivity != null) {
                  context.read<ActivityBloc>().add(
                        ActivityDeleted(
                          timestamp: widget.existingActivity!.id,
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
                  if (widget.existingActivity != null) {
                    context.read<ActivityBloc>().add(
                          ActivityEdited(
                            content: content,
                            id: widget.existingActivity!.id,
                          ),
                        );
                  } else {
                    context.read<ActivityBloc>().add(
                          ActivityAdded(
                            content: content,
                            isPrioritized: true,
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
