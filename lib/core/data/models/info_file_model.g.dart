// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoFile _$InfoFileFromJson(Map<String, dynamic> json) => InfoFile(
      name: json['name'] as String?,
      size: json['size'] as String?,
      path: json['path'] as String?,
      key: json['key'] as String?,
      progress: json['progress'] as String?,
      complete: json['complete'] as bool? ?? false,
      run: json['run'] as bool?,
    );

Map<String, dynamic> _$InfoFileToJson(InfoFile instance) => <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'size': instance.size,
      'key': instance.key,
      'progress': instance.progress,
      'complete': instance.complete,
      'run': instance.run,
    };
