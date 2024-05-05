import 'package:cron/data/entities/activity.dart';
import 'package:intl/intl.dart';

extension ActivityFormatter on Activity {
  String getTimeElapsedFormatted() {
    final dateTimeDifference = DateTime(0).add(currentProgress);

    final f = DateFormat('mm:ss');
    return f.format(dateTimeDifference);
  }

  String getTargetTimeFormatted() {
    final timeDifference = endTime.difference(startTime);
    final dateTimeDifference = DateTime(0).add(timeDifference);

    final f = DateFormat('mm:ss');
    return f.format(dateTimeDifference);
  }

  String getInitialTimeFormatted() {
    final f = DateFormat("hh'h'mm");
    return f.format(startTime);
  }

  String getFinalTimeFormatted() {
    final f = DateFormat("hh'h'mm");
    return f.format(endTime);
  }

  double getProgress() {
    final totalDuration = endTime.difference(startTime);

    return currentProgress.inMilliseconds / totalDuration.inMilliseconds;
  }
}
