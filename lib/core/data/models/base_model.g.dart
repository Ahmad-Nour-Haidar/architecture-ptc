// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel<T> _$BaseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseModel<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      meta: json['meta'] == null
          ? null
          : MetaList.fromJson(json['meta'] as Map<String, dynamic>),
      links: json['links'] == null
          ? null
          : LinksList.fromJson(json['links'] as Map<String, dynamic>),
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$BaseModelToJson<T>(
  BaseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'meta': instance.meta?.toJson(),
      'links': instance.links?.toJson(),
      'message': instance.message,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
