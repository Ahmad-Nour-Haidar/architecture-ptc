// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replay_box_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplayBox _$ReplayBoxFromJson(Map<String, dynamic> json) => ReplayBox(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      subTitle: json['sub_title'] as String?,
      showDate: json['show_date'] == null
          ? null
          : DateTime.parse(json['show_date'] as String),
      sendId: (json['send_id'] as num?)?.toInt(),
      recivedId: (json['recived_id'] as num?)?.toInt(),
      requestId: (json['request_id'] as num?)?.toInt(),
      recivedUser: json['recived_user'] == null
          ? null
          : UserModel.fromJson(json['recived_user'] as Map<String, dynamic>),
      sendUser: json['send_user'] == null
          ? null
          : UserModel.fromJson(json['send_user'] as Map<String, dynamic>),
      countFilse: (json['count_filse'] as num?)?.toInt(),
      files: (json['file'] as List<dynamic>?)
          ?.map((e) => FileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReplayBoxToJson(ReplayBox instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'show_date': instance.showDate?.toIso8601String(),
      'send_id': instance.sendId,
      'recived_id': instance.recivedId,
      'send_user': instance.sendUser?.toJson(),
      'recived_user': instance.recivedUser?.toJson(),
      'count_filse': instance.countFilse,
      'file': instance.files?.map((e) => e.toJson()).toList(),
      'request_id': instance.requestId,
    };
