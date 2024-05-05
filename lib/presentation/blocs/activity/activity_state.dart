import 'package:cron/data/entities/activity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_state.g.dart';

@JsonSerializable()
class ActivityState extends Equatable {
  final Set<Activity> presentFutureActivities;
  final Set<Activity> pastActivities;
  final DateTime latestTimeUpdated;

  const ActivityState({
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
}
