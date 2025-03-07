// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<ProfileModel> profileFromJson(String str) => List<ProfileModel>.from(json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileToJson(List<ProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
    final String name;
    final String profession;
    final String image;


    ProfileModel({
        required this.name,
        required this.profession,
        required this.image,

    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json["name"],
        profession: json["profession"],
        image: json["image"],

    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "profession": profession,
        "image": image,

    };
}
