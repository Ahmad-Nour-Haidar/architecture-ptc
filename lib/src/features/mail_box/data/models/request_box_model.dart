
import 'package:architecture_ptc/src/features/mail_box/data/models/replay_box_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../cache/data/models/users.dart';
import '../../../core/data/models/file_model.dart';


part 'request_box_model.g.dart';


///RequestBox
@JsonSerializable(explicitToJson: true)
class RequestBox {
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
  @JsonKey(name: "request_type_id")
  int? requestTypeId;
  @JsonKey(name: "request_type")
  String? requestType;
  @JsonKey(name: "send_user")
  UserModel? sendUser;
  @JsonKey(name: "recived_user")
  UserModel? recivedUser;
  @JsonKey(name: "count_replay_boxes")
  int? countReplayBoxes;
  @JsonKey(name: "count_filse",)
  int? countFilse;
  @JsonKey(name: "files",)
  List<FileModel>? files;
  @JsonKey(name: "replay_boxes",)
  List<ReplayBox>? replayBoxes;



  factory RequestBox.fromJson(Map<String, dynamic> json) {
    return _$RequestBoxFromJson(json);
  }
  Map<String, dynamic> toJson() => _$RequestBoxToJson(this);
  RequestBox({
    this.id,
    required this.title,
     this.subTitle,
     this.showDate,
     this.sendId,
    this.recivedId,
    this.requestTypeId,
    this.recivedUser,
    this.sendUser,
    this.countReplayBoxes,
    this.countFilse,
    this.requestType,
    this.files,
    this.replayBoxes,
  });
}

//@JsonSerializable(explicitToJson: true)
class RequestBoxes {
  List<RequestBox> listRequestBox;

  factory RequestBoxes.fromJson( json) {
    return _$RequestBoxesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RequestBoxesToJson(this);

  RequestBoxes({required this.listRequestBox});
}
RequestBoxes _$RequestBoxesFromJson(json) => RequestBoxes(
  listRequestBox: (json as List<dynamic>)
      .map((e) => RequestBox.fromJson(e as Map<String, dynamic>))
      .toList(),
);
Map<String, dynamic> _$RequestBoxesToJson(RequestBoxes instance) =>
    <String, dynamic>{
      'listRequestBox':
      instance.listRequestBox.map((e) => e.toJson()).toList(),
    };










