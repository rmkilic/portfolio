import 'dart:html' as html;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/resume_model.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/view-models/base_controller.dart';

class ResumeController extends BasePageController<ResumeModel> {
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();
  final storage = FirebaseStorage.instance;

  // Verileri önbellekte saklayalım
  ResumeModel? modelTR;
  ResumeModel? modelEN;

  @override
  Future<ResumeModel> fetchData(LanguageEnums language) async {
    // Dil Türkçe ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.tr && modelTR != null) {
      return modelTR!;
    }

    // Dil İngilizce ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.en && modelEN != null) {
      return modelEN!;
    }

    // Eğer veri yoksa API'den çekelim
    final data = await _firebaseService.getResume(language);

    // Gelen veriyi önbelleğe atalım
    if (language == LanguageEnums.tr) {
      modelTR = data;
    } else if (language == LanguageEnums.en) {
      modelEN = data;
    }

    return data;
  }

  Future<void> downloadFile(LanguageEnums language) async {
  try {
    final data = await _firebaseService.getDocument(language);

    String fileName = data.resume.split('/').last;

    // Firebase Storage referansını al
    final storageRef = storage.ref().child(data.resume);
    
    // Dosya URL'sini al
    final url = await storageRef.getDownloadURL();
    
    // Dosyayı indirmek için bir bağlantı oluştur
    final anchor = html.AnchorElement(href: url);
    anchor.setAttribute('download', fileName); 
    anchor.click(); 

    
  } catch (e) {
    Exception(e);
  }
}
}
