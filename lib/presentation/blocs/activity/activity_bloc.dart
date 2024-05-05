import 'dart:collection';

import 'package:cron/data/entities/activity.dart';
import 'package:cron/domain/activities_repository.dart';
import 'package:cron/domain/activities_transformer.dart';
import 'package:cron/presentation/blocs/activity/activity_event.dart';
import 'package:cron/presentation/blocs/activity/activity_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState>
    with HydratedMixin {
  late ActivityState currentState;

  ActivityBloc()
      : super(ActivityState(
            presentFutureActivities: LinkedList<Activity>(),
            pastActivities: LinkedList<Activity>(),
            latestTimeUpdated: DateTime.now())) {
    hydrate();
    on<ActivityAdded>(_onActivityAdded);
    on<ActivityDeleted>(_onActivityDeleted);

    on<UpdateActivities>(_onUpdateActivities);
    on<ToggleActivity>(_onToggleActivity);
    on<StopActivity>(_onStopActivity);

    Stream.periodic(const Duration(seconds: 1), (_) {}).listen((event) {
      add(UpdateActivities(
        currentTime: DateTime.now(),
      ));
    });

    currentState = state.copy();
  }

  // HydratedBloc part
  @override
  ActivityState fromJson(Map<String, dynamic> json) =>
      ActivityState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ActivityState state) => state.toJson();

  void update(
    Emitter<ActivityState> emitter,
  ) {
    emitter(currentState);
    currentState = state.copy();
  }

  // Events
  void _onActivityAdded(
    ActivityAdded event,
    Emitter<ActivityState> emitter,
  ) {
    final startTime = newActivitiyStartTime(isPrioritized: event.isPrioritized);

    final newActivity = event.activity.to(
      startTime: startTime,
      currentTime: startTime,
      status: ActivityStatus.notStarted,
    );

    addActivity(newActivity);
    update(emitter);

    add(UpdateActivities(currentTime: DateTime.now()));
  }

  void _onUpdateActivities(
    UpdateActivities event,
    Emitter<ActivityState> emitter,
  ) {
    Duration timeElapsed =
        event.currentTime.difference(state.latestTimeUpdated);
    currentState.latestTimeUpdated = event.currentTime;

    removeExpiredActivities(event.currentTime);
    playActivities(event.currentTime);
    incrementPlayingActivities(timeElapsed);
    incrementPausedActivities(timeElapsed);

    //currentState.presentFutureActivities = <Activity>{};

    update(emitter);
  }

  void _onToggleActivity(ToggleActivity event, Emitter<ActivityState> emitter) {
    final activity = event.activity;
    if (activity.status == ActivityStatus.inProgress) {
      pauseActivity(activity);
    } else {
      playActivity(activity);
    }
    update(emitter);
  }

  void _onStopActivity(StopActivity event, Emitter<ActivityState> emitter) {
    stopActivity(event.activity);
    update(emitter);
  }

  // void _onActivityEdited(ActivityEdited event, Emitter<ActivityState> emit) {
  //   final editedActivities = state.activities.map((note) {
  //     if (note.id == event.id) {
  //       return note.copyWith(content: event.content);
  //     }
  //     return note;
  //   }).toList();
  //   emit(ActivityState(activities: editedActivities));
  // }

  // void _onActivityDeleted(ActivityDeleted event, Emitter<ActivityState> emit) {
  //   final deletedActivities =
  //       state.activities.where((note) => note.id != event.timestamp).toList();
  //   emit(ActivityState(activities: deletedActivities));
  // }

  _onActivityDeleted(ActivityDeleted event, Emitter<ActivityState> emitter) {
    stopActivity(event.activity);
    update(emitter);
  }
}
