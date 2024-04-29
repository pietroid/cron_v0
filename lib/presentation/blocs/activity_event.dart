import 'package:equatable/equatable.dart';
import 'package:cron/data/entities/activity.dart';

class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class ActivityAdded extends ActivityEvent {
  final String content;
  final bool isPrioritized;
  final Duration duration;

  const ActivityAdded({
    required this.content,
    required this.isPrioritized,
    required this.duration,
  });

  @override
  List<Object> get props => [content, isPrioritized, duration];
}

class ActivityEdited extends ActivityEvent {
  final String content;
  final int id;

  const ActivityEdited({
    required this.content,
    required this.id,
  });

  @override
  List<Object> get props => [content, id];
}

class ActivityDeleted extends ActivityEvent {
  final Activity activity;

  const ActivityDeleted({required this.activity});

  @override
  List<Object> get props => [activity];
}

class RefreshActivities extends ActivityEvent {
  final DateTime currentTime;
  const RefreshActivities({required this.currentTime});
}

class ToggleActivity extends ActivityEvent {
  final Activity activity;
  const ToggleActivity({required this.activity});
}

class StopActivity extends ActivityEvent {
  final Activity activity;
  const StopActivity({required this.activity});
}
