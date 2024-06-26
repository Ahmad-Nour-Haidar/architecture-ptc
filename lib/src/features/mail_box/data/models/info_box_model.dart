
import 'package:json_annotation/json_annotation.dart';

part 'info_box_model.g.dart';


///InfoBox
@JsonSerializable(explicitToJson: true)
class InfoBox {
  @JsonKey(name: "count_send_boxes")
  int? countSendBoxes;
  @JsonKey(name: "count_recived_boxes")
  int? countRecivedBoxes;
  @JsonKey(name: "count_new_send_boxes")
  int? countNewSendBoxes;
  @JsonKey(name: "count_new_recived_boxes")
  int? countNewRecivedBoxes;

  factory InfoBox.fromJson(Map<String, dynamic> json) {
    return _$InfoBoxFromJson(json);
  }
  Map<String, dynamic> toJson() => _$InfoBoxToJson(this);
  InfoBox({
    this.countNewRecivedBoxes,
    this.countNewSendBoxes,
    this.countRecivedBoxes,
    this.countSendBoxes,
  });
}










