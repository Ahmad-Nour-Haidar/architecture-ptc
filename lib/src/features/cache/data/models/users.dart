
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';

///UserModel
@JsonSerializable()
class UserModel {
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
String? lastName;
  @JsonKey(name: "complete_name")
  String get completeName => "$firstName $lastName";

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "access_token")
  String? token;
  @JsonKey(name: "image")
String? image;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.about,
    this.password,
    this.image,
  });
}

