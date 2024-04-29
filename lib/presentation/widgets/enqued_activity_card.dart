import 'package:flutter/material.dart';
import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/formatters/activity_formatter.dart';
import 'package:cron/presentation/screens/activity_screen.dart';

class EnqueuedActivityCard extends StatefulWidget {
  final Activity activity;
  const EnqueuedActivityCard({super.key, required this.activity});

  @override
  State<EnqueuedActivityCard> createState() => _EnqueuedActivityCardState();
}

class _EnqueuedActivityCardState extends State<EnqueuedActivityCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3, // Add a shadow effect
      margin: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 2), // Add margin around the card
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8), // Add padding inside the card
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.activity.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            widget.activity.getInitialTimeFormatted(),
            style: theme.textTheme.bodySmall,
          ),
        ]),
        trailing: Text(
          widget.activity.getTargetTimeFormatted(),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityScreen(
                existingActivity: widget.activity,
              ),
            ),
          );
        },
      ),
    );
  }
}
