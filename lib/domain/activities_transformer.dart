import 'package:cron/data/entities/activity.dart';
import 'package:cron/domain/activity_transformer.dart';
import 'package:cron/presentation/blocs/activity/activity_bloc.dart';

extension ActivitiesTransformer on ActivityBloc {
  void addActivity(Activity activity) {
    currentState.presentFutureActivities.add(activity);
  }

  void pauseActivity(Activity activity) {
    _findActivity(activity).pause();
  }

  void playActivity(Activity activity) {
    _findActivity(activity).play();
  }

  void stopActivity(Activity activity) {
    final foundActivity = _findActivity(activity);

    currentState.presentFutureActivities.remove(foundActivity);
    foundActivity.stop();
    currentState.pastActivities.add(foundActivity);
  }

  void removeExpiredActivities(DateTime now) {
    final expiredActivities = currentState.presentFutureActivities
        .where((activity) => activity.endTime.isBefore(now))
        .toList();

    for (var activity in expiredActivities) {
      stopActivity(activity);
    }
  }

  void playActivities(DateTime now) {
    for (var activity in currentState.presentFutureActivities) {
      if (activity.status == ActivityStatus.notStarted &&
          activity.startTime.isBefore(now)) {
        activity.play();
      }
    }
  }

  void incrementPlayingActivities(Duration duration) {
    for (var activity in currentState.presentFutureActivities) {
      if (activity.status == ActivityStatus.inProgress) {
        activity.currentProgress += duration;
      }
    }
  }

  void incrementPausedActivities(Duration duration) {
    for (var activity in currentState.presentFutureActivities) {
      if (activity.status == ActivityStatus.paused) {
        activity.duration += duration;
      }
    }
  }

  void solveOverlappingActivities() {
    final activities = currentState.presentFutureActivities;

    for (var activity in activities) {
      activity.avoidOverlappingMoveThisBasedOnPast();
    }
  }

  Activity _findActivity(Activity activity) {
    return currentState.presentFutureActivities
        .firstWhere((element) => element.id == activity.id);
  }
}
