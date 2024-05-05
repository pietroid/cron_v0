import 'dart:collection';

import 'package:cron/data/entities/activity.dart';
import 'package:json_annotation/json_annotation.dart';

class LinkedListConverter
    extends JsonConverter<LinkedList<Activity>, List<Map<String, dynamic>>> {
  const LinkedListConverter();

  @override
  LinkedList<Activity> fromJson(List<Map<String, dynamic>> json) {
    return LinkedList<Activity>()
      ..addAll(json.map((instance) => Activity.fromJson(instance)));
  }

  @override
  List<Map<String, dynamic>> toJson(LinkedList<Activity> object) {
    return object.map((item) => item.toJson()).toList();
  }
}
