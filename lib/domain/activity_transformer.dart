import 'package:cron/data/entities/activity.dart';

extension ActivityTrasnformer on Activity {
  void play() {
    status = ActivityStatus.inProgress;
  }

  void pause() {
    status = ActivityStatus.paused;
  }

  void stop() {
    status = ActivityStatus.completed;
  }

  void avoidOverlappingMoveThisBasedOnPast() {
    if (isFixed) return;
    // Move this activity to the past if it overlaps with past activity
    final pastActivity = previous;
    if (pastActivity != null && pastActivity.endTime.isAfter(startTime)) {
      final offset = pastActivity.endTime.difference(startTime);
      startTime = startTime.add(offset);
    }

    // check if next is fixed
    if (next != null && next!.isFixed && next!.startTime.isBefore(endTime)) {
      final nextActivity = next!;
      startTime = nextActivity.endTime;
    }
  }
}
