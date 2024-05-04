import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity with EquatableMixin {
  int id;
  DateTime startTime;
  DateTime endTime;
  DateTime currentTime;

  Duration duration;

  ActivityStatus status;

  String content;

  bool isFixed;

  Activity({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.currentTime,
    required this.duration,
    required this.status,
    required this.content,
    required this.isFixed,
  });

  @override
  List<Object> get props =>
      [id, startTime, endTime, currentTime, status, content];

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity to({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? currentTime,
    Duration? duration,
    ActivityStatus? status,
    String? content,
    bool? isFixed,
  }) {
    return Activity(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      currentTime: currentTime ?? this.currentTime,
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
      endTime: DateTime(0),
      currentTime: DateTime(0),
      duration: Duration.zero,
      status: ActivityStatus.enqueued,
      content: '',
      isFixed: false,
    );
  }
}

enum ActivityStatus {
  enqueued,
  inProgress,
  paused,
  completed,
  cancelled,
}
