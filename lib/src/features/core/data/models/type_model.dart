
import 'package:json_annotation/json_annotation.dart';


part 'type_model.g.dart';


///TypeModel
@JsonSerializable(explicitToJson: true)
class TypeModel {
  final int? id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "type")
  String? type;
  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return _$TypeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TypeModelToJson(this);

  TypeModel({
    this.id,
    this.type,
    required this.name,
  });
}

//@JsonSerializable(explicitToJson: true)
class TypeModels {
  List<TypeModel> listTypeModel;

  factory TypeModels.fromJson(Map<String, dynamic> json) {
    return _$TypeModelsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TypeModelsToJson(this);

  TypeModels({required this.listTypeModel});

}
TypeModels _$TypeModelsFromJson(json) => TypeModels(
  listTypeModel: (json as List<dynamic>)
      .map((e) => TypeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
Map<String, dynamic> _$TypeModelsToJson(TypeModels instance) =>
    <String, dynamic>{
      'listTypeModel':
      instance.listTypeModel.map((e) => e.toJson()).toList(),
    };












