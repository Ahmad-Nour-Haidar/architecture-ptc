// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_box_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBox _$RequestBoxFromJson(Map<String, dynamic> json) => RequestBox(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      subTitle: json['sub_title'] as String?,
      showDate: json['show_date'] == null
          ? null
          : DateTime.parse(json['show_date'] as String),
      sendId: (json['send_id'] as num?)?.toInt(),
      recivedId: (json['recived_id'] as num?)?.toInt(),
      requestTypeId: (json['request_type_id'] as num?)?.toInt(),
      recivedUser: json['recived_user'] == null
          ? null
          : UserModel.fromJson(json['recived_user'] as Map<String, dynamic>),
      sendUser: json['send_user'] == null
          ? null
          : UserModel.fromJson(json['send_user'] as Map<String, dynamic>),
      countReplayBoxes: (json['count_replay_boxes'] as num?)?.toInt(),
      countFilse: (json['count_filse'] as num?)?.toInt(),
      requestType: json['request_type'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      replayBoxes: (json['replay_boxes'] as List<dynamic>?)
          ?.map((e) => ReplayBox.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestBoxToJson(RequestBox instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'show_date': instance.showDate?.toIso8601String(),
      'send_id': instance.sendId,
      'recived_id': instance.recivedId,
      'request_type_id': instance.requestTypeId,
      'request_type': instance.requestType,
      'send_user': instance.sendUser?.toJson(),
      'recived_user': instance.recivedUser?.toJson(),
      'count_replay_boxes': instance.countReplayBoxes,
      'count_filse': instance.countFilse,
      'files': instance.files?.map((e) => e.toJson()).toList(),
      'replay_boxes': instance.replayBoxes?.map((e) => e.toJson()).toList(),
    };
