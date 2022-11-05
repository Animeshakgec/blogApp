// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addBlogModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBlogModel _$AddBlogModelFromJson(Map<String, dynamic> json) => AddBlogModel(
      id: json['_id'],
      coverImage: json['coverImage'],
      username: json['username'],
      title: json['title'],
      body: json['body'],
      count: json['count'],
      share: json['share'],
      comment: json['comment'],
    );

Map<String, dynamic> _$AddBlogModelToJson(AddBlogModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'share': instance.share,
      'comment': instance.comment,
      '_id': instance.id,
      'coverImage': instance.coverImage,
      'username': instance.username,
      'title': instance.title,
      'body': instance.body,
    };
