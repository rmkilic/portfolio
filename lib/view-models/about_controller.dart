import 'package:get_it/get_it.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/view-models/base_controller.dart';

class AboutController extends BasePageController<AboutModel> {
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();

  // Verileri önbellekte saklayalım
  AboutModel? modelTR;
  AboutModel? modelEN;

  @override
  Future<AboutModel> fetchData(LanguageEnums language) async {
    // Dil Türkçe ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.tr && modelTR != null) {
      return modelTR!;
    }

    // Dil İngilizce ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.en && modelEN != null) {
      return modelEN!;
    }

    // Eğer veri yoksa API'den çekelim
    final data = await _firebaseService.getAbout(language);

    // Gelen veriyi önbelleğe atalım
    if (language == LanguageEnums.tr) {
      modelTR = data;
    } else if (language == LanguageEnums.en) {
      modelEN = data;
    }

    return data;
  }
}
