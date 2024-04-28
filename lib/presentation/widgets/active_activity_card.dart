import 'package:flutter/material.dart';
import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/presentation/activity_formatter.dart';

class PlayingActivityCard extends StatefulWidget {
  final Activity activity;
  const PlayingActivityCard({super.key, required this.activity});

  @override
  State<PlayingActivityCard> createState() => _PlayingActivityCardState();
}

class _PlayingActivityCardState extends State<PlayingActivityCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.activity.content,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const PlayPauseButton(),
            ]),
            const SizedBox(
              height: 24,
            ),
            const ProgressBar(),
            const SizedBox(
              height: 8,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(widget.activity.getTimeElapsedFormatted()),
              Text(widget.activity.getTargetTimeFormatted())
            ]),
            const SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                widget.activity.getInitialTimeFormatted(),
                style: theme.textTheme.bodySmall,
              ),
              Text(
                widget.activity.getFinalTimeFormatted(),
                style: theme.textTheme.bodySmall,
              )
            ]),
          ],
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LinearProgressIndicator(
      backgroundColor: theme.progressIndicatorTheme.refreshBackgroundColor,
      value: 0.5,
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      onPressed: () {
        //
      },
    );
  }
}
