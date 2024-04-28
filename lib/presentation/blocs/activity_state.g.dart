// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityState _$ActivityStateFromJson(Map<String, dynamic> json) =>
    ActivityState(
      enqued: (json['enqued'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentlyActive: (json['currentlyActive'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      inactive: (json['inactive'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ActivityStateToJson(ActivityState instance) =>
    <String, dynamic>{
      'enqued': instance.enqued,
      'currentlyActive': instance.currentlyActive,
      'inactive': instance.inactive,
    };
