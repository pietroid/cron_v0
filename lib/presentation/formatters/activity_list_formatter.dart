import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/blocs/activity/activity_state.dart';

extension ActivityListFormatter on ActivityState {
  List<Activity> allOrderedActivities() {
    final playingActivities = presentFutureActivities
        .where((activity) => activity.status == ActivityStatus.inProgress)
        .toList();

    final pausedActivities = presentFutureActivities
        .where((activity) => activity.status == ActivityStatus.paused)
        .toList();

    final enquedActivities = presentFutureActivities
        .where((activity) => activity.status == ActivityStatus.notStarted)
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
