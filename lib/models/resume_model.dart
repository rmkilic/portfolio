// To parse this JSON data, do
//
//     final resume = resumeFromJson(jsonString);

import 'dart:convert';

ResumeModel resumeFromJson(String str) => ResumeModel.fromJson(json.decode(str));

String resumeToJson(ResumeModel data) => json.encode(data.toJson());

class ResumeModel {
    final List<Education> education;
    final Profession profession;
    final Summary summary;

    ResumeModel({
        required this.education,
        required this.profession,
        required this.summary,
    });

    factory ResumeModel.fromJson(Map<String, dynamic> json)
    {
      json;
      return ResumeModel(
        education:List<Education>.from(
  json["education"].map((x) => Education.fromJson(x))
),
        profession: Profession.fromJson(json["profession"]),
        summary: Summary.fromJson(json["summary"]),
    );
    }

    Map<String, dynamic> toJson() => {
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "profession": profession.toJson(),
        "summary": summary.toJson(),
    };
}

class Education {
    final String name;
    final String school;
    final String title;
    final String year;

    Education({
        required this.name,
        required this.school,
        required this.title,
        required this.year,
    });

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        name: json["name"],
        school: json["school"],
        title: json["title"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "school": school,
        "title": title,
        "year": year,
    };
}

class Profession {
    final List<Business> business;
    final String title;

    Profession({
        required this.business,
        required this.title,
    });

    factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        business: List<Business>.from(json["business"].map((x) => Business.fromJson(x))),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "business": List<dynamic>.from(business.map((x) => x.toJson())),
        "title": title,
    };
}

class Business {
    final String company;
    final String description;
    final String name;
    final List<Project> project;
    final String year;

    Business({
        required this.company,
        required this.description,
        required this.name,
        required this.project,
        required this.year,
    });

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        company: json["company"],
        description: json["description"],
        name: json["name"],
        project: List<Project>.from(json["project"].map((x) => Project.fromJson(x))),
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "company": company,
        "description": description,
        "name": name,
        "project": List<dynamic>.from(project.map((x) => x.toJson())),
        "year": year,
    };
}

class Project {
    final String description;
    final String name;

    Project({
        required this.description,
        required this.name,
    });

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        description: json["description"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "name": name,
    };
}

class Summary {
    final String about;
    final Contact contact;
    final String name;
    final String title;

    Summary({
        required this.about,
        required this.contact,
        required this.name,
        required this.title,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        about: json["about"],
        contact: Contact.fromJson(json["contact"]),
        name: json["name"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "about": about,
        "contact": contact.toJson(),
        "name": name,
        "title": title,
    };
}

class Contact {
    final String city;
    final String email;
    final String github;
    final String linkedin;
    final String phone;

    Contact({
        required this.city,
        required this.email,
        required this.github,
        required this.linkedin,
        required this.phone,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        city: json["city"],
        email: json["email"],
        github: json["github"],
        linkedin: json["linkedin"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "email": email,
        "github": github,
        "linkedin": linkedin,
        "phone": phone,
    };
}
