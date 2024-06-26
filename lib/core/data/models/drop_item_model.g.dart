// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropItemModel _$DropItemModelFromJson(Map<String, dynamic> json) =>
    DropItemModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      origin: json['origin'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$DropItemModelToJson(DropItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'origin': instance.origin,
      'image': instance.image,
    };
