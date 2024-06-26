
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';




///MetaList
@JsonSerializable(explicitToJson: true)
class MetaList {
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "from")
  int? from;
  @JsonKey(name: "path")
  String? path;
  @JsonKey(name: "per_page")
  int? perPage;
  int? to;
  int? total;

  factory MetaList.fromJson(Map<String, dynamic> json) {
    return _$MetaListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetaListToJson(this);

  MetaList({
    this.currentPage,
    this.from,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });
}

///LinksList
@JsonSerializable(explicitToJson: true)
class LinksList {
  @JsonKey(name: "first")
  String? first;
  @JsonKey(name: "next")
  String? next;
  @JsonKey(name: "prev")
  String? prev;
  @JsonKey(name: "last")
  String? last;

  factory LinksList.fromJson(Map<String, dynamic> json) {
    return _$LinksListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LinksListToJson(this);

  LinksList({
    this.first,
    this.next,
    this.prev,
    this.last,
  });
}


