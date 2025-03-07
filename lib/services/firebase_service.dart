import 'dart:io';

import 'package:dio/dio.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/enums/network_path_enums.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/models/document_model.dart';
import 'package:portfolio/models/experience_model.dart';
import 'package:portfolio/models/freelance_model.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/models/program_model.dart';
import 'package:portfolio/models/references_model.dart';
import 'package:portfolio/models/resume_model.dart';


class FirebaseService {
  final Dio dio;


  FirebaseService({required this.dio});

    ///General get functions
    Future<dynamic> _fetchData({required LanguageEnums language, required NetworkPathEnums path})async
    {
      try
      {
        final uri = "${path.getPath}${language.path}";
        final response = await dio.get(uri);
        if(response.statusCode == HttpStatus.ok)
        {
          return response.data;
        }
        else
        {
          return Future.error("Error: ${path.name.toUpperCase()} ${response.statusCode}");
        }
      }
      catch(e)
      {
      throw Exception('Failed to load ${path.name.toUpperCase()}: $e');

      }
    }

    Future<List<ProgramModel>> getPrograms(LanguageEnums language) async {
      final List jsonModel = await _fetchData(language: language, path: NetworkPathEnums.program);
      return jsonModel.map((e) => ProgramModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    Future<AboutModel> getAbout(LanguageEnums language) async {
      final  jsonModel = await _fetchData(language: language, path: NetworkPathEnums.about);
      return  AboutModel.fromJson(jsonModel);
    }

    Future<List<ExperienceModel>> getExperience(LanguageEnums language) async {
      final List jsonModel = await _fetchData(language: language, path: NetworkPathEnums.experience);
      return jsonModel.map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    Future<ResumeModel> getResume(LanguageEnums language) async {
      try
      {
        final  jsonModel = await _fetchData(language: language, path: NetworkPathEnums.resume);
        return  ResumeModel.fromJson(jsonModel.first);
      }
      catch(e)
      {
        throw Exception(e);
      }
    }

    Future<List<ReferencesModel>> getReferences(LanguageEnums language) async {
      final List jsonModel = await _fetchData(language: language, path: NetworkPathEnums.reference);
      return jsonModel.map((e) => ReferencesModel.fromJson(e as Map<String, dynamic>)).toList();
    }

      Future<ProfileModel> getProfile(LanguageEnums language) async {
      final  jsonModel = await _fetchData(language: language, path: NetworkPathEnums.profile);
      return  ProfileModel.fromJson(jsonModel);
    }

        Future<List<FreelanceModel>> getFreelanceProject(LanguageEnums language) async {
      final List jsonModel = await _fetchData(language: language, path: NetworkPathEnums.freelance);
      return jsonModel.map((e) => FreelanceModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    Future<DocumentModel> getDocument(LanguageEnums language) async {
      final  jsonModel = await _fetchData(language: language, path: NetworkPathEnums.document);
      return  DocumentModel.fromJson(jsonModel);
    }





    
}
