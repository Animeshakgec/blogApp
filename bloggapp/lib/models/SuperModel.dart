// To parse this JSON data, do
//
//     final supermodels = supermodelsFromJson(jsonString);

import 'dart:convert';

List<Supermodels> supermodelsFromJson(String str) => List<Supermodels>.from(
    json.decode(str).map((x) => Supermodels.fromJson(x)));

String supermodelsToJson(List<Supermodels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supermodels {
  Supermodels({
    required this.id,
    required this.username,
    required this.title,
    required this.body,
    required this.coverImage,
    required this.like,
    required this.share,
    required this.comment,
    required this.v,
  });

  String id;
  String username;
  String title;
  String body;
  String coverImage;
  int like;
  int share;
  int comment;
  int v;

  factory Supermodels.fromJson(Map<String, dynamic> json) => Supermodels(
        id: json["_id"],
        username: json["username"],
        title: json["title"],
        body: json["body"],
        coverImage: json["coverImage"],
        like: json["like"],
        share: json["share"],
        comment: json["comment"],
        v: json["__v"],
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
        "__v": v,
      };
}
