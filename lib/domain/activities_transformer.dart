import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/presentation/blocs/activity_bloc.dart';
import 'package:smart_activities/presentation/blocs/activity_state.dart';

extension ActivitiesTransformer on ActivityBloc {
  ActivityState addActivity(Activity activity) {
    final newEnqueued = List<Activity>.from(state.enqued);
    newEnqueued.add(activity);

    return state.to(
      enqued: newEnqueued,
    );
  }

  ActivityState playActivity(Activity activity) {
    activity.status = ActivityStatus.inProgress;

    final newEnqueued = List<Activity>.from(state.enqued);
    final newCurrentlyActive = List<Activity>.from(state.currentlyActive);

    newEnqueued.remove(activity);
    newCurrentlyActive.add(activity);

    return state.to(
      enqued: newEnqueued,
      currentlyActive: newCurrentlyActive,
    );
  }
}
