import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/presentation/blocs/activity_bloc.dart';
import 'package:smart_activities/presentation/blocs/activity_state.dart';
import 'package:smart_activities/presentation/screens/activity_screen.dart';
import 'package:smart_activities/presentation/widgets/active_activity_card.dart';
import 'package:smart_activities/presentation/widgets/enqued_activity_card.dart';

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
              MaterialPageRoute(builder: (context) => const ActivityScreen()),
            );
          }),
      body: SafeArea(
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            final cards = [
              ...state.currentlyActive,
              ...state.enqued.reversed.where((activity) =>
                  activity.status != ActivityStatus.cancelled &&
                  activity.status != ActivityStatus.completed),
            ];

            return Column(children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final activity = cards[index];
                    if (activity.status == ActivityStatus.inProgress ||
                        activity.status == ActivityStatus.paused) {
                      return PlayingActivityCard(activity: activity);
                    } else if (activity.status == ActivityStatus.enqueued) {
                      return EnqueuedActivityCard(activity: activity);
                    }
                    return null;
                  },
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
