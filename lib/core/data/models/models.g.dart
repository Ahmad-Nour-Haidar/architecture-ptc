// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaList _$MetaListFromJson(Map<String, dynamic> json) => MetaList(
      currentPage: (json['current_page'] as num?)?.toInt(),
      from: (json['from'] as num?)?.toInt(),
      path: json['path'] as String?,
      perPage: (json['per_page'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetaListToJson(MetaList instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'from': instance.from,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };

LinksList _$LinksListFromJson(Map<String, dynamic> json) => LinksList(
      first: json['first'] as String?,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$LinksListToJson(LinksList instance) => <String, dynamic>{
      'first': instance.first,
      'next': instance.next,
      'prev': instance.prev,
      'last': instance.last,
    };
