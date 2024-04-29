import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/blocs/activity_state.dart';

extension ActivityListFormatter on ActivityState {
  List<Activity> allOrderedActivities() {
    final playingActivities = futureActivities
        .where((activity) => activity.status == ActivityStatus.inProgress)
        .toList();

    final pausedActivities = futureActivities
        .where((activity) => activity.status == ActivityStatus.paused)
        .toList();

    final enquedActivities = futureActivities
        .where((activity) => activity.status == ActivityStatus.enqueued)
        .toList();

    final playingActivitiesSorted = playingActivities.toList()
      ..sort(_compareByDate);

    final pausedActivitiesSorted = pausedActivities.toList()
      ..sort(_compareByDate);

    final enquedActivitiesSorted = enquedActivities.toList()
      ..sort(_compareByDate);

    return [
      ...playingActivitiesSorted,
      ...pausedActivitiesSorted,
      ...enquedActivitiesSorted,
    ];
  }

  int _compareByDate(Activity a, Activity b) {
    return a.startTime.compareTo(b.startTime);
  }
}
