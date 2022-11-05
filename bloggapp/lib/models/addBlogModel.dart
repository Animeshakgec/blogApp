import 'package:json_annotation/json_annotation.dart';

part 'addBlogModel.g.dart';

@JsonSerializable()
class AddBlogModel {
  var count;
  var share;
  var comment;
  @JsonKey(name: "_id")
  var id;
  var coverImage;
  var username;
  var title;
  var body;
  AddBlogModel(
      {this.id,
      this.coverImage,
      this.username,
      this.title,
      this.body,
      this.count,
      this.share,
      this.comment});

  factory AddBlogModel.fromJson(Map<String, dynamic> json) =>
      _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
