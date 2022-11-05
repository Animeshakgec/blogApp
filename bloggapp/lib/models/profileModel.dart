import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  var name;
  var username;
  var profession;
  var dob;
  var titlename;
  var about;
  ProfileModel(
      {this.dob,
      this.about,
      this.name,
      this.profession,
      this.titlename,
      this.username});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
