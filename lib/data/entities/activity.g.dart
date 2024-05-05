// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      duration: Duration(microseconds: json['duration'] as int),
      currentProgress: Duration(microseconds: json['currentProgress'] as int),
      status: $enumDecode(_$ActivityStatusEnumMap, json['status']),
      content: json['content'] as String,
      isFixed: json['isFixed'] as bool,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
      'currentProgress': instance.currentProgress.inMicroseconds,
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'content': instance.content,
      'isFixed': instance.isFixed,
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.notStarted: 'notStarted',
  ActivityStatus.inProgress: 'inProgress',
  ActivityStatus.paused: 'paused',
  ActivityStatus.completed: 'completed',
  ActivityStatus.cancelled: 'cancelled',
};
