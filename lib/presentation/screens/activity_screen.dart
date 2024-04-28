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
  Duration duration = const Duration(minutes: 15);
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
              top: 20,
              bottom: 70,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: _controller,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descrição',
                    ),
                    maxLines: null,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tempo:'),
                        TimeActionChoice(
                          onChanged: (Duration duration) {
                            setState(() {
                              this.duration = duration;
                            });
                          },
                        ),
                      ]),
                ]),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 156, 10, 0),
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
              Icons.directions_run,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
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
                              isPrioritized: false,
                            ),
                          );
                    }
                    Navigator.pop(context);
                  },
            child: const Icon(
              Icons.check,
            ),
          )
        ]));
  }
}

class TimeActionChoice extends StatefulWidget {
  final void Function(Duration duration) onChanged;
  const TimeActionChoice({
    super.key,
    required this.onChanged,
  });

  @override
  State<TimeActionChoice> createState() => _TimeActionChoiceState();
}

class _TimeActionChoiceState extends State<TimeActionChoice> {
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    final Map<String, Duration> timeMap = {
      '15 min': const Duration(minutes: 15),
      '30 min': const Duration(minutes: 30),
      '1h': const Duration(hours: 1),
    };

    return Wrap(
      spacing: 5.0,
      children: List<Widget>.generate(
        3,
        (int index) {
          return ChoiceChip(
            selectedColor: theme.colorScheme.secondary,
            labelStyle: textTheme.bodyMedium,
            label: Text(timeMap.keys.elementAt(index)),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
              widget.onChanged(
                timeMap.values.elementAt(index),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
