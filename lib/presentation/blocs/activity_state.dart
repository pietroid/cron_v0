import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_activities/data/entities/activity.dart';

part 'activity_state.g.dart';

@JsonSerializable()
class ActivityState extends Equatable {
  final List<Activity> enqued;
  final List<Activity> currentlyActive;
  final List<Activity> inactive;

  const ActivityState({
    this.enqued = const [],
    this.currentlyActive = const [],
    this.inactive = const [],
  });

  @override
  List<Object?> get props => [
        Object.hashAll(
          enqued.map((element) => element.hashCode),
        ),
        Object.hashAll(
          currentlyActive.map((element) => element.hashCode),
        ),
        Object.hashAll(
          inactive.map((element) => element.hashCode),
        ),
      ];

  ActivityState to({
    List<Activity>? enqued,
    List<Activity>? currentlyActive,
    List<Activity>? inactive,
  }) {
    return ActivityState(
      enqued: enqued ?? this.enqued,
      currentlyActive: currentlyActive ?? this.currentlyActive,
      inactive: inactive ?? this.inactive,
    );
  }

  factory ActivityState.fromJson(Map<String, dynamic> json) =>
      _$ActivityStateFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityStateToJson(this);
}
