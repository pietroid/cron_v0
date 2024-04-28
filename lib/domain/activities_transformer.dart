import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/presentation/blocs/activity_bloc.dart';
import 'package:smart_activities/presentation/blocs/activity_state.dart';

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

  ActivityState _replaceActivity(Activity activity, Activity newActivity) {
    final newFutureActivities = Set<Activity>.from(state.futureActivities);
    newFutureActivities.remove(activity);
    newFutureActivities.add(newActivity);

    return state.to(
      futureActivities: newFutureActivities,
    );
  }

  ActivityState refreshActiveStatesWithCurrentTime(DateTime currentTime) {
    final newFutureActivities = state.futureActivities
        .map((activity) => activity.to(
              currentTime: currentTime,
            ))
        .toSet();

    return state.to(
      futureActivities: newFutureActivities,
    );
  }
}
