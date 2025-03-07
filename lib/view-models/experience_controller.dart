import 'package:get_it/get_it.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/experience_model.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/view-models/base_controller.dart';

class ExperienceController extends BasePageController<List<ExperienceModel>> {
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();

  // Verileri önbellekte saklayalım
  List<ExperienceModel>? modelTR;
  List<ExperienceModel>? modelEN;

  @override
  Future<List<ExperienceModel>> fetchData(LanguageEnums language) async {
    // Dil Türkçe ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.tr && modelTR != null) {
      return modelTR!;
    }

    // Dil İngilizce ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.en && modelEN != null) {
      return modelEN!;
    }

    // Eğer veri yoksa API'den çekelim
    final data = await _firebaseService.getExperience(language);

    // Gelen veriyi önbelleğe atalım
    if (language == LanguageEnums.tr) {
      modelTR = data;
    } else if (language == LanguageEnums.en) {
      modelEN = data;
    }

    return data;
  }
}
