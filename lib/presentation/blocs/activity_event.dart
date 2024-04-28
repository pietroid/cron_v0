import 'package:equatable/equatable.dart';

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
