import 'package:equatable/equatable.dart';
import 'package:smart_activities/data/entities/activity.dart';

class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class ActivityAdded extends ActivityEvent {
  final String content;
  final bool isPrioritized;

  const ActivityAdded({
    required this.content,
    required this.isPrioritized,
  });

  @override
  List<Object> get props => [content, isPrioritized];
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
  final int timestamp;

  const ActivityDeleted({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
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
