// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityState _$ActivityStateFromJson(Map<String, dynamic> json) =>
    ActivityState(
      presentFutureActivities: const LinkedListConverter().fromJson(
          json['presentFutureActivities'] as List<Map<String, dynamic>>),
      pastActivities: const LinkedListConverter()
          .fromJson(json['pastActivities'] as List<Map<String, dynamic>>),
      latestTimeUpdated: DateTime.parse(json['latestTimeUpdated'] as String),
    );

Map<String, dynamic> _$ActivityStateToJson(ActivityState instance) =>
    <String, dynamic>{
      'presentFutureActivities':
          const LinkedListConverter().toJson(instance.presentFutureActivities),
      'pastActivities':
          const LinkedListConverter().toJson(instance.pastActivities),
      'latestTimeUpdated': instance.latestTimeUpdated.toIso8601String(),
    };
