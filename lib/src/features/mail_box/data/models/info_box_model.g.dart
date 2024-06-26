// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_box_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoBox _$InfoBoxFromJson(Map<String, dynamic> json) => InfoBox(
      countNewRecivedBoxes: (json['count_new_recived_boxes'] as num?)?.toInt(),
      countNewSendBoxes: (json['count_new_send_boxes'] as num?)?.toInt(),
      countRecivedBoxes: (json['count_recived_boxes'] as num?)?.toInt(),
      countSendBoxes: (json['count_send_boxes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InfoBoxToJson(InfoBox instance) => <String, dynamic>{
      'count_send_boxes': instance.countSendBoxes,
      'count_recived_boxes': instance.countRecivedBoxes,
      'count_new_send_boxes': instance.countNewSendBoxes,
      'count_new_recived_boxes': instance.countNewRecivedBoxes,
    };
