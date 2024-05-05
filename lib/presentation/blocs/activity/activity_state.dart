import 'dart:collection';

import 'package:cron/data/entities/activity.dart';
import 'package:cron/data/linked_list_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_state.g.dart';

@JsonSerializable()
class ActivityState with EquatableMixin {
  @LinkedListConverter()
  LinkedList<Activity> presentFutureActivities;

  @LinkedListConverter()
  LinkedList<Activity> pastActivities;
  DateTime latestTimeUpdated;

  ActivityState({
    required this.presentFutureActivities,
    required this.pastActivities,
    required this.latestTimeUpdated,
  });

  @override
  List<Object> get props => [
        presentFutureActivities,
        pastActivities,
        latestTimeUpdated,
      ];

  ActivityState to({
    LinkedList<Activity>? presentFutureActivities,
    LinkedList<Activity>? pastActivities,
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
      presentFutureActivities: LinkedList<Activity>()
        ..addAll(presentFutureActivities.map((activity) => Activity(
            id: activity.id,
            startTime: activity.startTime,
            currentProgress: activity.currentProgress,
            duration: activity.duration,
            status: activity.status,
            content: activity.content,
            isFixed: activity.isFixed))),
      pastActivities: LinkedList<Activity>()
        ..addAll(pastActivities.map((activity) => Activity(
            id: activity.id,
            startTime: activity.startTime,
            currentProgress: activity.currentProgress,
            duration: activity.duration,
            status: activity.status,
            content: activity.content,
            isFixed: activity.isFixed))),
      latestTimeUpdated: latestTimeUpdated,
    );
  }
}
