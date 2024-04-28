import 'package:flutter/material.dart';
import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/presentation/screens/activity_screen.dart';

class EnqueuedActivityCard extends StatefulWidget {
  final Activity activity;
  const EnqueuedActivityCard({super.key, required this.activity});

  @override
  State<EnqueuedActivityCard> createState() => _EnqueuedActivityCardState();
}

class _EnqueuedActivityCardState extends State<EnqueuedActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Add a shadow effect
      margin: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4), // Add margin around the card
      child: ListTile(
        title: Text(
          widget.activity.content,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
