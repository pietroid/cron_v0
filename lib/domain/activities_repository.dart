import 'package:cron/presentation/blocs/activity/activity_bloc.dart';

extension ActivitiesRepository on ActivityBloc {
  DateTime newActivitiyStartTime({
    required isPrioritized,
  }) {
    if (isPrioritized) {
      return DateTime.now();
    }
    DateTime latestActivityEndTime = DateTime.now();
    if (state.presentFutureActivities.isNotEmpty) {
      latestActivityEndTime = state.presentFutureActivities
          .map((activity) => activity.endTime)
          .reduce((value, element) => value.isAfter(element) ? value : element);
    }
    return latestActivityEndTime;
  }
}
