import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/blocs/activity/activity_bloc.dart';
import 'package:cron/presentation/blocs/activity/activity_event.dart';
import 'package:cron/presentation/blocs/activity/activity_state.dart';
import 'package:cron/presentation/formatters/activity_list_formatter.dart';
import 'package:cron/presentation/screens/activity_screen.dart';
import 'package:cron/presentation/widgets/active_activity_card.dart';
import 'package:cron/presentation/widgets/enqued_activity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
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
            final List<Activity> allActivities = state.allOrderedActivities();
            return Column(children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allActivities.length,
                  itemBuilder: (context, index) {
                    final activity = allActivities[index];
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final activityBloc = context.read<ActivityBloc>();
    if (state == AppLifecycleState.resumed) {
      activityBloc.add(RefreshActivities(currentTime: DateTime.now()));
    }
  }
}
