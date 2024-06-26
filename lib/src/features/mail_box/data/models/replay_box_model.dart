
import 'package:architecture_ptc/src/features/cache/data/models/users.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/data/models/file_model.dart';


part 'replay_box_model.g.dart';


///ReplayBox
@JsonSerializable(explicitToJson: true)
class ReplayBox {
  final int? id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "sub_title")
  String? subTitle;
  @JsonKey(name: "show_date")
  DateTime? showDate;
  @JsonKey(name: "send_id")
  int? sendId;
  @JsonKey(name: "recived_id")
  int? recivedId;
  @JsonKey(name: "send_user")
  UserModel? sendUser;
  @JsonKey(name: "recived_user")
  UserModel? recivedUser;
  @JsonKey(name: "count_filse",)
  int? countFilse;
  @JsonKey(name: "file",)
  List<FileModel>? files;
  @JsonKey(name: "request_id")
  int? requestId;


  factory ReplayBox.fromJson(Map<String, dynamic> json) {
    return _$ReplayBoxFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ReplayBoxToJson(this);
  ReplayBox({
    this.id,
    required this.title,
     this.subTitle,
     this.showDate,
     this.sendId,
    this.recivedId,
    this.requestId,
    this.recivedUser,
    this.sendUser,
    this.countFilse,
    this.files,
  });
}

//@JsonSerializable(explicitToJson: true)
class ReplayBoxes {
  List<ReplayBox> listReplayBox;

  factory ReplayBoxes.fromJson(Map<String, dynamic> json) {
    return _$ReplayBoxesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReplayBoxesToJson(this);

  ReplayBoxes({required this.listReplayBox});
}
ReplayBoxes _$ReplayBoxesFromJson(json) => ReplayBoxes(
  listReplayBox: (json as List<dynamic>)
      .map((e) => ReplayBox.fromJson(e as Map<String, dynamic>))
      .toList(),
);
Map<String, dynamic> _$ReplayBoxesToJson(ReplayBoxes instance) =>
    <String, dynamic>{
      'listReplayBox':
      instance.listReplayBox.map((e) => e.toJson()).toList(),
    };










