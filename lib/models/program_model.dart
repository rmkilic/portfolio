// To parse this JSON data, do
//
//     final program = programFromJson(jsonString);

import 'dart:convert';

ProgramModel programFromJson(String str) => ProgramModel.fromJson(json.decode(str));

String programToJson(ProgramModel data) => json.encode(data.toJson());

class ProgramModel {
    final String? description;
    final String? features;
    final String? images;
    final int? index;
    final String? name;
    final String? platform;
    final String? aspectRatio;
    

    ProgramModel({
        this.description,
        this.features,
        this.images,
        this.index,
        this.name,
        this.platform,
        this.aspectRatio,
    });

    factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        description: json["description"] ?? "",
        features: json["features"]?? "",
        images: json["images"]?? "",
        index: json["index"],
        name: json["name"]?? "",
        platform: json["platform"]?? "",
        aspectRatio: json["aspectRatio"]?? "",
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "features": features,
        "images": images,
        "index": index,
        "name": name,
        "platform": platform,
        "aspectRatio": aspectRatio,
    };
}
