// import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';

// import 'addBlogModel.dart';

// part 'SuperModel.g.dart';

// @JsonSerializable()
// class SuperModel {
//   final List<AddBlogModel> data;
//   SuperModel({required this.data});
//   factory SuperModel.fromJson(Map<String, dynamic> json) =>
//       _$SuperModelFromJson(json);
//   Map<String, dynamic> toJson() => _$SuperModelToJson(this);
// }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.data,
  });

  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.username,
    this.title,
    this.body,
    this.coverImage,
    this.like,
    this.share,
    this.comment,
  });

  var like;
  var share;
  var comment;
  var id;
  var coverImage;
  var username;
  var title;
  var body;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        title: json["title"],
        body: json["body"],
        coverImage: json["coverImage"],
        like: json["like"],
        share: json["share"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "title": title,
        "body": body,
        "coverImage": coverImage,
        "like": like,
        "share": share,
        "comment": comment,
      };
}
