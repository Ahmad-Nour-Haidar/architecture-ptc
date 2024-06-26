import 'package:json_annotation/json_annotation.dart';
part 'drop_item_model.g.dart';


///DropItemModel
@JsonSerializable(explicitToJson: true)
class DropItemModel {
  final int? id;

  String? name;
  String? origin;
  String? image;

  DropItemModel({
    this.id,
    this.name,
     this.origin,
     this.image,
  });

  factory DropItemModel.fromJson(Map<String, dynamic> json) {
    return _$DropItemModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DropItemModelToJson(this);

}






