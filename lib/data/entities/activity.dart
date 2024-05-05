import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
final class Activity extends LinkedListEntry<Activity> with EquatableMixin {
  int id;
  DateTime startTime;

  Duration duration;
  Duration currentProgress;

  ActivityStatus status;

  String content;

  bool isFixed;

  DateTime get endTime => startTime.add(duration);

  Activity({
    required this.id,
    required this.startTime,
    required this.duration,
    required this.currentProgress,
    required this.status,
    required this.content,
    required this.isFixed,
  });

  @override
  List<Object> get props =>
      [id, startTime, duration, currentProgress, status, content];

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity to({
    int? id,
    DateTime? startTime,
    Duration? currentProgress,
    Duration? duration,
    ActivityStatus? status,
    String? content,
    bool? isFixed,
  }) {
    return Activity(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      currentProgress: currentProgress ?? this.currentProgress,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      content: content ?? this.content,
      isFixed: isFixed ?? this.isFixed,
    );
  }

  factory Activity.empty() {
    return Activity(
      id: -1,
      startTime: DateTime(0),
      currentProgress: Duration.zero,
      duration: Duration.zero,
      status: ActivityStatus.notStarted,
      content: '',
      isFixed: false,
    );
  }
}

enum ActivityStatus {
  notStarted,
  inProgress,
  paused,
  completed,
  cancelled,
}
