import 'package:intl/intl.dart';
import 'package:smart_activities/data/entities/activity.dart';

extension ActivityFormatter on Activity {
  String getTimeElapsedFormatted() {
    final timeDifference = currentTime.difference(startTime);
    final dateTimeDifference = DateTime(0).add(timeDifference);

    final f = DateFormat('hh:mm:ss');
    return f.format(dateTimeDifference);
  }

  String getTargetTimeFormatted() {
    final timeDifference = startTime.difference(DateTime.now());
    final dateTimeDifference = DateTime(0).add(timeDifference);

    final f = DateFormat('hh:mm:ss');
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
}
