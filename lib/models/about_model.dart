// To parse this JSON data, do
//
//     final about = aboutFromJson(jsonString);

import 'dart:convert';

AboutModel aboutFromJson(String str) => AboutModel.fromJson(json.decode(str));

String aboutToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
    final String birthday;
    final String city;
    final String degree;
    final String description;
    final String drivingLicence;
    final String email;
    final String freelance;
    final String militaryService;
    final String phone;
    final String profession;
    final List<Skill> skills;

    AboutModel({
        required this.birthday,
        required this.city,
        required this.degree,
        required this.description,
        required this.drivingLicence,
        required this.email,
        required this.freelance,
        required this.militaryService,
        required this.phone,
        required this.profession,
        required this.skills,
    });

    factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
        birthday: json["birthday"],
        city: json["city"],
        degree: json["degree"],
        description: json["description"],
        drivingLicence: json["driving licence"],
        email: json["email"],
        freelance: json["freelance"],
        militaryService: json["military service"],
        phone: json["phone"],
        profession: json["profession"],
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "city": city,
        "degree": degree,
        "description": description,
        "driving licence": drivingLicence,
        "email": email,
        "freelance": freelance,
        "military service": militaryService,
        "phone": phone,
        "profession": profession,
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
    };
}

class Skill {
    final int level;
    final String name;

    Skill({
        required this.level,
        required this.name,
    });

    factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        level: json["level"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "level": level,
        "name": name,
    };
}
