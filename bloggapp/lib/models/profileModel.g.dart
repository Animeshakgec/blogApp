// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      dob: json['dob'],
      about: json['about'],
      name: json['name'],
      profession: json['profession'],
      titlename: json['titlename'],
      username: json['username'],
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'profession': instance.profession,
      'dob': instance.dob,
      'titlename': instance.titlename,
      'about': instance.about,
    };
