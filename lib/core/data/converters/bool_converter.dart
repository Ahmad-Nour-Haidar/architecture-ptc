import 'package:json_annotation/json_annotation.dart';

class BoolConverter implements JsonConverter<bool?, int?> {
  const BoolConverter();

  @override
  bool? fromJson(int? json) {
    if (json == null) return null;
    return json == 1;
  }

  @override
  int? toJson(bool? object) {
    if (object == null) return null;
    return object ? 1 : 0;
  }
}