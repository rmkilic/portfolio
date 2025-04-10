/* import 'package:get_it/get_it.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/view-models/base_controller.dart';

class ProfileController extends BasePageController<ProfileModel> {
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();

  // Verileri önbellekte saklayalım
  ProfileModel? modelTR;
  ProfileModel? modelEN;

  

  @override
  Future<ProfileModel> fetchData(LanguageEnums language) async {
    // Dil Türkçe ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.tr && modelTR != null) {
      return modelTR!;
    }

    // Dil İngilizce ise ve veri daha önce çekilmişse
    if (language == LanguageEnums.en && modelEN != null) {
      return modelEN!;
    }

    // Eğer veri yoksa API'den çekelim
    final data = await _firebaseService.getProfile(language);

    // Gelen veriyi önbelleğe atalım
    if (language == LanguageEnums.tr) {
      modelTR = data;
    } else if (language == LanguageEnums.en) {
      modelEN = data;
    }

    return data;
  }
}


 */
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portfolio/core/constant/config.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/view-models/base_controller.dart';

class ProfileController extends BasePageController<ProfileModel> {
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();
  final cacheBox = Hive.box(Config.cacheMemory); // Hive cache kutusu
final storage = FirebaseStorage.instance;
  ProfileModel? modelTR;
  ProfileModel? modelEN;

  String? cachedImageUrl;

  @override
  Future<ProfileModel> fetchData(LanguageEnums language) async {
    if (language == LanguageEnums.tr && modelTR != null) {
      return modelTR!;
    }
    if (language == LanguageEnums.en && modelEN != null) {
      return modelEN!;
    }

    final data = await _firebaseService.getProfile(language);

    // Resim URL'sini cache'e alalım
   // await cacheProfileImage(data.image);
    await getCachedImageUrl(data);

    if (language == LanguageEnums.tr) {
      modelTR = data;
    } else if (language == LanguageEnums.en) {
      modelEN = data;
    }

    return data;
  }

  // Resim URL'sini cache'leme
  Future<void> cacheProfileImage(String imageUrl) async {
    String? cachedUrl = cacheBox.get('profile_image_url');

    // URL değişmişse cache’i güncelle
    if (cachedUrl != imageUrl) {

      await cacheBox.put('profile_image_url', imageUrl);
      cachedImageUrl = imageUrl;
    } else {
      cachedImageUrl = cachedUrl;
    }
  }
Future<String> getCachedImageUrl(ProfileModel item) async {
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
  String? getCachedProfileImage(ProfileModel? item) {
    String? val = cachedImageUrl ?? cacheBox.get(item?.image ?? "");
    return val;
  }
}
