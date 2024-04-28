import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_activities/data/entities/activity.dart';
import 'package:smart_activities/domain/activities_transformer.dart';
import 'package:smart_activities/presentation/blocs/activity_event.dart';
import 'package:smart_activities/presentation/blocs/activity_state.dart';
import 'package:smart_activities/utils/activity_id_generator.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState>
    with HydratedMixin {
  ActivityBloc() : super(const ActivityState()) {
    hydrate();
    on<ActivityAdded>(_onActivityAdded);
    on<RefreshPlayingActivities>(_onRefreshPlayingActivities);
    on<ToggleActivity>(_onToggleActivity);

    // on<ActivityEdited>(_onActivityEdited);
    // on<ActivityDeleted>(_onActivityDeleted);

    Stream.periodic(const Duration(seconds: 1), (_) {}).listen((event) {
      add(RefreshPlayingActivities(
        currentTime: DateTime.now(),
      ));
    });
  }

  // HydratedBloc part
  @override
  ActivityState fromJson(Map<String, dynamic> json) =>
      ActivityState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ActivityState state) => state.toJson();

  // Events
  void _onActivityAdded(
    ActivityAdded event,
    Emitter<ActivityState> emit,
  ) {
    final startTime = DateTime.now();

    final newActivity = Activity(
      id: ActivityIdGenerator().generateId(),
      startTime: startTime,
      currentTime: startTime,
      endTime: startTime.add(const Duration(minutes: 15)),
      status: ActivityStatus.enqueued,
      content: event.content,
    );

    final activityState = addActivity(newActivity);
    emit(activityState);

    if (event.isPrioritized) {
      final activityState = playActivity(newActivity);
      emit(activityState);
    }
  }

  void _onRefreshPlayingActivities(
    RefreshPlayingActivities event,
    Emitter<ActivityState> emit,
  ) {
    final activityState =
        incrementPlayingActivities(const Duration(seconds: 1));
    emit(activityState);
  }

  void _onToggleActivity(ToggleActivity event, Emitter<ActivityState> emit) {
    final activity = event.activity;
    if (activity.status == ActivityStatus.inProgress) {
      final activityState = pauseActivity(activity);
      emit(activityState);
    } else {
      final activityState = playActivity(activity);
      emit(activityState);
    }
  }

  // void _onActivityEdited(ActivityEdited event, Emitter<ActivityState> emit) {
  //   final editedActivitys = state.activities.map((note) {
  //     if (note.id == event.id) {
  //       return note.copyWith(content: event.content);
  //     }
  //     return note;
  //   }).toList();
  //   emit(ActivityState(activities: editedActivitys));
  // }

  // void _onActivityDeleted(ActivityDeleted event, Emitter<ActivityState> emit) {
  //   final deletedActivitys =
  //       state.activities.where((note) => note.id != event.timestamp).toList();
  //   emit(ActivityState(activities: deletedActivitys));
  // }
}
