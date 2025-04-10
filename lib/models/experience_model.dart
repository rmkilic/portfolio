// To parse this JSON data, do
//
//     final experience = experienceFromJson(jsonString);

import 'dart:convert';

List<ExperienceModel> experienceFromJson(String str) => List<ExperienceModel>.from(json.decode(str).map((x) => ExperienceModel.fromJson(x)));

String experienceToJson(List<ExperienceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExperienceModel {
    final String endYear;
    final String name;
    final String position;
    final String startYear;

    ExperienceModel({
        required this.endYear,
        required this.name,
        required this.position,
        required this.startYear,
    });

    factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
        endYear: json["endYear"],
        name: json["name"],
        position: json["position"],
        startYear: json["startYear"],
    );

    Map<String, dynamic> toJson() => {
        "endYear": endYear,
        "name": name,
        "position": position,
        "startYear": startYear,
    };
}
