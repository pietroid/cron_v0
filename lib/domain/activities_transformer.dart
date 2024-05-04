import 'package:cron/data/entities/activity.dart';
import 'package:cron/presentation/blocs/activity/activity_bloc.dart';
import 'package:cron/presentation/blocs/activity/activity_state.dart';

extension ActivitiesTransformer on ActivityBloc {
  ActivityState addActivity(Activity activity) {
    final newFutureActivities = Set<Activity>.from(state.futureActivities);

    newFutureActivities.add(activity);

    return state.to(
      futureActivities: newFutureActivities,
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

    final newFutureActivities = Set<Activity>.from(state.futureActivities);
    newFutureActivities.remove(activity);

    final newPastActivities = Set<Activity>.from(state.pastActivities);
    newPastActivities.add(newActivity);

    return state.to(
      futureActivities: newFutureActivities,
      pastActivities: newPastActivities,
    );
  }

  ActivityState startNextOnQueueIfNecessary() {
    final playingActivities = state.futureActivities
        .where((activity) => activity.status == ActivityStatus.inProgress)
        .toList();

    if (playingActivities.isEmpty) {
      final enqueuedActivities = state.futureActivities
          .where((activity) =>
              activity.status == ActivityStatus.enqueued ||
              activity.status == ActivityStatus.paused)
          .toList();

      if (enqueuedActivities.isNotEmpty) {
        final newActivity = enqueuedActivities.first.to(
          status: ActivityStatus.inProgress,
        );

        return _replaceActivity(enqueuedActivities.first, newActivity);
      }
    }

    return state;
  }

  ActivityState removeExpiredActivities(DateTime now) {
    final newFutureActivities = state.futureActivities
        .where((activity) => activity.endTime.isAfter(now))
        .toSet();

    return state.to(
      futureActivities: newFutureActivities,
    );
  }

  ActivityState _replaceActivity(Activity activity, Activity newActivity) {
    final newFutureActivities = Set<Activity>.from(state.futureActivities);
    newFutureActivities.remove(activity);
    newFutureActivities.add(newActivity);

    return state.to(
      futureActivities: newFutureActivities,
    );
  }

  ActivityState incrementPlayingActivities(Duration duration) {
    final newPlayingActivities = state.futureActivities.map((activity) {
      if (activity.status == ActivityStatus.inProgress) {
        return activity.to(currentTime: activity.currentTime.add(duration));
      }
      return activity;
    }).toSet();

    return state.to(
      futureActivities: newPlayingActivities,
    );
  }

  ActivityState incrementNotPlayingActivities(Duration duration) {
    final newFutureActivities = state.futureActivities.map((activity) {
      if (activity.status == ActivityStatus.paused) {
        return activity.to(endTime: activity.endTime.add(duration));
      }
      return activity;
    }).toSet();

    return state.to(
      futureActivities: newFutureActivities,
    );
  }
}
