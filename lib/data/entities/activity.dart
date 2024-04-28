import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity with EquatableMixin {
  int id;
  DateTime startTime;
  DateTime endTime;
  DateTime currentTime;

  ActivityStatus status;

  String content;

  Activity({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.currentTime,
    required this.status,
    required this.content,
  });

  @override
  List<Object> get props => [id, startTime, endTime, status, content];

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

enum ActivityStatus {
  enqueued,
  inProgress,
  paused,
  completed,
  cancelled,
}
