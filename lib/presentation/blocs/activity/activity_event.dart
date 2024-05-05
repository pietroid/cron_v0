import 'package:cron/data/entities/activity.dart';
import 'package:equatable/equatable.dart';

class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class ActivityAdded extends ActivityEvent {
  final Activity activity;

  final bool isPrioritized;

  const ActivityAdded({
    required this.activity,
    required this.isPrioritized,
  });

  @override
  List<Object> get props => [activity, isPrioritized];
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

class UpdateActivities extends ActivityEvent {
  final DateTime currentTime;
  const UpdateActivities({required this.currentTime});
}

class ToggleActivity extends ActivityEvent {
  final Activity activity;
  const ToggleActivity({required this.activity});
}

class StopActivity extends ActivityEvent {
  final Activity activity;
  const StopActivity({required this.activity});
}
