// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NameModel _$NameModelFromJson(Map<String, dynamic> json) => NameModel(
      id: (json['id'] as num?)?.toInt(),
      origin: json['origin'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NameModelToJson(NameModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'origin': instance.origin,
    };
