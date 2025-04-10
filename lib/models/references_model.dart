// To parse this JSON data, do
//
//     final references = referencesFromJson(jsonString);

import 'dart:convert';

List<ReferencesModel> referencesFromJson(String str) => List<ReferencesModel>.from(json.decode(str).map((x) => ReferencesModel.fromJson(x)));

String referencesToJson(List<ReferencesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferencesModel {
    final String linkedin;
    final String name;
    final String phone;
    final String position;
    final String image;

    ReferencesModel({
        required this.linkedin,
        required this.name,
        required this.phone,
        required this.position,
        required this.image,
    });

    factory ReferencesModel.fromJson(Map<String, dynamic> json) => ReferencesModel(
        linkedin: json["linkedin"],
        name: json["name"],
        phone: json["phone"],
        position: json["position"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "linkedin": linkedin,
        "name": name,
        "phone": phone,
        "position": position,
        "image": image,
    };
}
