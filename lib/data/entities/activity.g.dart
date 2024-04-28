// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      currentTime: DateTime.parse(json['currentTime'] as String),
      status: $enumDecode(_$ActivityStatusEnumMap, json['status']),
      content: json['content'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'currentTime': instance.currentTime.toIso8601String(),
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'content': instance.content,
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.enqueued: 'enqueued',
  ActivityStatus.inProgress: 'inProgress',
  ActivityStatus.paused: 'paused',
  ActivityStatus.completed: 'completed',
  ActivityStatus.cancelled: 'cancelled',
};
