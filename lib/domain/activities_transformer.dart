import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/blocs/activity/activity_bloc.dart';
import 'package:cron/presentation/blocs/activity/activity_state.dart';

extension ActivitiesTransformer on ActivityBloc {
  ActivityState addActivity(Activity activity) {
    final newFutureActivities =
        Set<Activity>.from(state.presentFutureActivities);

    newFutureActivities.add(activity);

    return state.to(
      presentFutureActivities: newFutureActivities,
    );
  }

  ActivityState playActivity(Activity activity) {
    final newActivity = activity.to(
      status: ActivityStatus.inProgress,
    );

    return _replaceActivity(activity, newActivity);
  }

  ActivityState pauseActivity(Activity activity) {
    final newActivity = activity.to(
      status: ActivityStatus.paused,
    );

    return _replaceActivity(activity, newActivity);
  }

  ActivityState stopActivity(Activity activity) {
    final newActivity = activity.to(
      status: ActivityStatus.completed,
    );

    final newFutureActivities =
        Set<Activity>.from(state.presentFutureActivities);
    newFutureActivities.remove(activity);

    final newPastActivities = Set<Activity>.from(state.pastActivities);
    newPastActivities.add(newActivity);

    return state.to(
      presentFutureActivities: newFutureActivities,
      pastActivities: newPastActivities,
    );
  }

  ActivityState removeExpiredActivities(DateTime now) {
    final newFutureActivities = state.presentFutureActivities
        .where((activity) => activity.endTime.isAfter(now))
        .toSet();

    return state.to(
      presentFutureActivities: newFutureActivities,
    );
  }

  ActivityState _replaceActivity(Activity activity, Activity newActivity) {
    final newFutureActivities =
        Set<Activity>.from(state.presentFutureActivities);
    newFutureActivities.remove(activity);
    newFutureActivities.add(newActivity);

    return state.to(
      presentFutureActivities: newFutureActivities,
    );
  }

  ActivityState playActivities(DateTime now) {
    final newFutureActivities = state.presentFutureActivities.map((activity) {
      if (activity.status == ActivityStatus.notStarted &&
          activity.startTime.isBefore(now)) {
        return activity.to(status: ActivityStatus.inProgress);
      }
      return activity;
    }).toSet();

    return state.to(
      presentFutureActivities: newFutureActivities,
    );
  }

  ActivityState incrementPlayingActivities(Duration duration) {
    final newPlayingActivities = state.presentFutureActivities.map((activity) {
      if (activity.status == ActivityStatus.inProgress) {
        return activity.to(currentTime: activity.currentTime.add(duration));
      }
      return activity;
    }).toSet();

    return state.to(
      presentFutureActivities: newPlayingActivities,
    );
  }

  ActivityState incrementPausedActivities(Duration duration) {
    final newFutureActivities = state.presentFutureActivities.map((activity) {
      if (activity.status == ActivityStatus.paused) {
        return activity.to(duration: activity.duration + duration);
      }
      return activity;
    }).toSet();

    return state.to(
      presentFutureActivities: newFutureActivities,
    );
  }
}
