import 'package:intl/intl.dart';

mixin DateConversionMixin {
  // تحويل التاريخ المحلي إلى توقيت UTC عند تحويله إلى JSON
  Map<String, dynamic> toJsonWithUtc(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (value is DateTime) {
        json[key] = value.toUtc().toIso8601String();
      }
    });
    return json;
  }
  // تحويل التاريخ UTC إلى التاريخ المحلي عند قراءته من JSON
  static Map<String, dynamic> fromJsonWithLocal(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (value is String && DateTime.tryParse(value) != null) {
        json[key] = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(value).toLocal();
      }
    });
    return json;
  }
}