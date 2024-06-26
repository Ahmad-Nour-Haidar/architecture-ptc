// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      id: (json['id'] as num?)?.toInt(),
      path: json['path'] as String?,
      name: json['name'] as String?,
      size: (json['size'] as num?)?.toInt(),
      type: json['type'] as String?,
      sub_type: json['sub_type'] as String?,
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'size': instance.size,
      'type': instance.type,
      'sub_type': instance.sub_type,
    };
