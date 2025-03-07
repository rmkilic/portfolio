// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
    final String resume;

    DocumentModel({
        required this.resume,
    });

    factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        resume: json["resume"],
    );

    Map<String, dynamic> toJson() => {
        "resume": resume,
    };
}
