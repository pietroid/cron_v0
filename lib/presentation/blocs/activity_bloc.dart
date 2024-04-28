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

    // on<ActivityEdited>(_onActivityEdited);
    // on<ActivityDeleted>(_onActivityDeleted);
  }

  // HydratedBloc part
  @override
  ActivityState fromJson(Map<String, dynamic> json) =>
      ActivityState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ActivityState state) => state.toJson();

  // Events
  void _onActivityAdded(ActivityAdded event, Emitter<ActivityState> emit) {
    final startTime = DateTime.now();

    final newActivity = Activity(
      id: ActivityIdGenerator().generateId(),
      startTime: startTime,
      currentTime: startTime,
      endTime: DateTime.now(),
      status: ActivityStatus.enqueued,
      content: event.content,
    );

    final activityState = addActivity(newActivity);
    emit(activityState);

    // if (event.isPrioritized) {
    //   final activityState = playActivity(newActivity);
    //   emit(activityState);
    // }
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
