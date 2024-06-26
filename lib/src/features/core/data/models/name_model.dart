
import 'package:json_annotation/json_annotation.dart';
part 'name_model.g.dart';


///NameModel
@JsonSerializable(explicitToJson: true)
class NameModel {
  final int? id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "origin")
  String origin;
  factory NameModel.fromJson(Map<String, dynamic> json) {
    return _$NameModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NameModelToJson(this);

  NameModel({
    this.id,
    required this.origin,
    required this.name,
  });
  factory NameModel.init()=>NameModel(origin: '', name: '');
}

//@JsonSerializable(explicitToJson: true)
class NameModels {
  List<NameModel> listNameModel;

  factory NameModels.fromJson(Map<String, dynamic> json) {
    return _$NameModelsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NameModelsToJson(this);

  NameModels({required this.listNameModel});

}
NameModels _$NameModelsFromJson(json) => NameModels(
  listNameModel: (json as List<dynamic>)
      .map((e) => NameModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
Map<String, dynamic> _$NameModelsToJson(NameModels instance) =>
    <String, dynamic>{
      'listNameModel':
      instance.listNameModel.map((e) => e.toJson()).toList(),
    };












