import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_activities/data/entities/activity.dart';

part 'activity_state.g.dart';

@JsonSerializable()
class ActivityState extends Equatable {
  final Set<Activity> futureActivities;
  final Set<Activity> pastActivities;
  final DateTime latestTimeUpdated;

  const ActivityState({
    this.futureActivities = const {},
    this.pastActivities = const {},
    required this.latestTimeUpdated,
  });

  @override
  List<Object> get props => [
        futureActivities,
        pastActivities,
        latestTimeUpdated,
      ];

  ActivityState to({
    Set<Activity>? futureActivities,
    Set<Activity>? pastActivities,
    DateTime? latestTimeUpdated,
  }) {
    return ActivityState(
      futureActivities: futureActivities ?? this.futureActivities,
      pastActivities: pastActivities ?? this.pastActivities,
      latestTimeUpdated: latestTimeUpdated ?? this.latestTimeUpdated,
    );
  }

  factory ActivityState.fromJson(Map<String, dynamic> json) =>
      _$ActivityStateFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityStateToJson(this);
}
