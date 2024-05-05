// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityState _$ActivityStateFromJson(Map<String, dynamic> json) =>
    ActivityState(
      presentFutureActivities:
          (json['presentFutureActivities'] as List<dynamic>?)
                  ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
                  .toSet() ??
              const {},
      pastActivities: (json['pastActivities'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      latestTimeUpdated: DateTime.parse(json['latestTimeUpdated'] as String),
    );

Map<String, dynamic> _$ActivityStateToJson(ActivityState instance) =>
    <String, dynamic>{
      'presentFutureActivities': instance.presentFutureActivities.toList(),
      'pastActivities': instance.pastActivities.toList(),
      'latestTimeUpdated': instance.latestTimeUpdated.toIso8601String(),
    };
