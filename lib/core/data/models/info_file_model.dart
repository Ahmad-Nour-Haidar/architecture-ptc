
import 'package:json_annotation/json_annotation.dart';
part 'info_file_model.g.dart';


///InfoFile
@JsonSerializable(explicitToJson: true)
class InfoFile {

  @JsonKey(name: "path")
  String? path;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "size")
  String? size;
  @JsonKey(name: "key")
  String? key;
  @JsonKey(name: "progress")
  String? progress;
  @JsonKey(name: "complete")
  bool? complete;
  @JsonKey(name: "run")
  bool? run;

  factory InfoFile.fromJson(Map<String, dynamic> json) {
    return _$InfoFileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InfoFileToJson(this);

  InfoFile(
      {

        this.name,
        this.size,
        this.path,
        this.key,
        this.progress,
        this.complete = false,
        this.run});
}






