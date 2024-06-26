
import 'package:json_annotation/json_annotation.dart';


part 'file_model.g.dart';



///FileModel
@JsonSerializable(explicitToJson: true)
class FileModel {
  final int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "path")
  String? path;
  @JsonKey(name: "size")
  int? size;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "sub_type")
  String? sub_type;

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return _$FileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FileModelToJson(this);

  FileModel({
    this.id,
    this.path,
     this.name,
     this.size,
     this.type,
     this.sub_type,
  });
}

//@JsonSerializable(explicitToJson: true)
class FileModels {
  List<FileModel> listFileModel;

  factory FileModels.fromJson(json) {
    return _$FileModelsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FileModelsToJson(this);

  FileModels({required this.listFileModel});

  getFileIds(){
    List<int> listFileIds=[];
    for(FileModel fileModel in listFileModel) {
      if(fileModel.id!=null) {
        listFileIds.add(fileModel.id!);
    }
      }
    return listFileIds;
  }

}
FileModels _$FileModelsFromJson(json) => FileModels(
  listFileModel: (json as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
Map<String, dynamic> _$FileModelsToJson(FileModels instance) =>
    <String, dynamic>{
      'listFileModel':
      instance.listFileModel.map((e) => e.toJson()).toList(),
    };












