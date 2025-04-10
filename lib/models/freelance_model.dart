// To parse this JSON data, do
//
//     final freelanceModel = freelanceModelFromJson(jsonString);

import 'dart:convert';

List<FreelanceModel> freelanceModelFromJson(String str) => List<FreelanceModel>.from(json.decode(str).map((x) => FreelanceModel.fromJson(x)));

String freelanceModelToJson(List<FreelanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FreelanceModel {
    final String aspectRatio;
    final String description;
    final List<Feature> features;
    final String image;
    final String name;
    final String title;
    final int type;

    FreelanceModel({
        required this.aspectRatio,
        required this.description,
        required this.features,
        required this.image,
        required this.name,
        required this.title,
        required this.type,
    });

    factory FreelanceModel.fromJson(Map<String, dynamic> json) => FreelanceModel(
        aspectRatio: json["aspectRatio"],
        description: json["description"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        image: json["image"],
        name: json["name"],
        title: json["title"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "aspectRatio": aspectRatio,
        "description": description,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "image": image,
        "name": name,
        "title": title,
        "type": type,
    };
}

class Feature {
    final String title;

    Feature({
        required this.title,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
    };
}
