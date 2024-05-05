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
}
