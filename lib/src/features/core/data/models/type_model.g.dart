// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeModel _$TypeModelFromJson(Map<String, dynamic> json) => TypeModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TypeModelToJson(TypeModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };
