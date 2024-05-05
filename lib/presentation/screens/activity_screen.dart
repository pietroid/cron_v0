import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/blocs/activity/activity_bloc.dart';
import 'package:cron/presentation/blocs/activity/activity_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityScreen extends StatefulWidget {
  final Activity? existingActivity;
  const ActivityScreen({super.key, this.existingActivity});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late TextEditingController _controller;

  late Activity activity;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.existingActivity?.content);
    activity = Activity.empty();
    activity.id = DateTime.now().millisecondsSinceEpoch;
    //TODO associate with initial state
    activity.duration = const Duration(minutes: 5);
    super.initState();
  }

  void update() => setState(() {});

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
                          activity: widget.existingActivity!,
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
                      activity.content = value;
                      update();
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
                            activity.duration = duration;
                            update();
                          },
                        ),
                      ]),
                ]),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: const Color.fromARGB(255, 156, 10, 0),
            onPressed: activity.content.isEmpty
                ? null
                : () {
                    if (widget.existingActivity != null) {
                      context.read<ActivityBloc>().add(
                            ActivityAdded(
                              activity: activity,
                              isPrioritized: true,
                            ),
                          );
                    } else {
                      context.read<ActivityBloc>().add(
                            ActivityAdded(
                              activity: activity,
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
            onPressed: activity.content.isEmpty
                ? null
                : () {
                    if (widget.existingActivity != null) {
                      context.read<ActivityBloc>().add(
                            ActivityEdited(
                              content: activity.content,
                              id: widget.existingActivity!.id,
                            ),
                          );
                    } else {
                      context.read<ActivityBloc>().add(
                            ActivityAdded(
                              activity: activity,
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
      '5 min': const Duration(minutes: 5),
      '15 min': const Duration(minutes: 15),
      '30 min': const Duration(minutes: 30),
      '45 min': const Duration(minutes: 45),
    };

    return Wrap(
      spacing: 5.0,
      children: List<Widget>.generate(
        4,
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
