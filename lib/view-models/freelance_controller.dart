import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:portfolio/core/constant/config.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/freelance_model.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/view-models/base_controller.dart';

class FreelanceController extends BasePageController<List<FreelanceModel>> {
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();
  final storage = FirebaseStorage.instance;
  final cacheBox = Hive.box(Config.cacheMemory); // Hive cache kutusu
  var selectedProgram = Rx<FreelanceModel?>(null);
  String? cachedImageUrl;

  // Verileri önbellekte saklayalım
  List<FreelanceModel>? modelTR;
  List<FreelanceModel>? modelEN;

  @override
  Future<List<FreelanceModel>> fetchData(LanguageEnums language) async {
    // Dil Türkçe ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.tr && modelTR != null) {
      return modelTR!;
    }

    // Dil İngilizce ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.en && modelEN != null) {
      return modelEN!;
    }

    // Eğer veri yoksa API'den çekelim
    final data = await _firebaseService.getFreelanceProject(language);
      for(var item in data)
    {
    // Resim URL'sini cache'e alalım
    await cacheImage(item);
    }
    // Gelen veriyi önbelleğe atalım
    if (language == LanguageEnums.tr) {
      modelTR = data;
    } else if (language == LanguageEnums.en) {
      modelEN = data;
    }

    return data;
  }

      // Resim URL'sini cache'leme
  Future<String> cacheImage(FreelanceModel item) async {

        // 1. Cache kontrolü
    if (cacheBox.containsKey(item.image)) {
      return cacheBox.get(item.image);
    }

    // 2. Cache yoksa Firebase’den URL al
    final ref = storage.ref().child(item.image);
    final downloadUrl = await ref.getDownloadURL();

    // 3. URL'yi cache’e kaydet
    cacheBox.put(item.image, downloadUrl);

    return downloadUrl;
  }

  // Cache’ten resim URL’sini al
  String? getCachedProfileImage(FreelanceModel item) {
 
    return cachedImageUrl ?? cacheBox.get(item.image);
  }
}
