import 'package:cron/data/entities/activity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_state.g.dart';

@JsonSerializable()
class ActivityState with EquatableMixin {
  Set<Activity> presentFutureActivities;
  Set<Activity> pastActivities;
  DateTime latestTimeUpdated;

  ActivityState({
    this.presentFutureActivities = const {},
    this.pastActivities = const {},
    required this.latestTimeUpdated,
  });

  @override
  List<Object> get props => [
        presentFutureActivities,
        pastActivities,
        latestTimeUpdated,
      ];

  ActivityState to({
    Set<Activity>? presentFutureActivities,
    Set<Activity>? pastActivities,
    DateTime? latestTimeUpdated,
  }) {
    return ActivityState(
      presentFutureActivities:
          presentFutureActivities ?? this.presentFutureActivities,
      pastActivities: pastActivities ?? this.pastActivities,
      latestTimeUpdated: latestTimeUpdated ?? this.latestTimeUpdated,
    );
  }

  factory ActivityState.fromJson(Map<String, dynamic> json) =>
      _$ActivityStateFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityStateToJson(this);

  ActivityState copy() {
    return ActivityState(
      presentFutureActivities: presentFutureActivities
          .map((activity) => Activity(
              id: activity.id,
              startTime: activity.startTime,
              currentTime: activity.currentTime,
              duration: activity.duration,
              status: activity.status,
              content: activity.content,
              isFixed: activity.isFixed))
          .toSet(),
      pastActivities: pastActivities
          .map((activity) => Activity(
              id: activity.id,
              startTime: activity.startTime,
              currentTime: activity.currentTime,
              duration: activity.duration,
              status: activity.status,
              content: activity.content,
              isFixed: activity.isFixed))
          .toSet(),
      latestTimeUpdated: latestTimeUpdated,
    );
  }
}
