import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portfolio/core/constant/config.dart';

class ProfileImageViewModel extends GetxController {
  var imageUrl = ''.obs; // Resim URL'si state olarak tutulacak.
  var errorMessage = ''.obs; // Hata mesajı için bir state ekledik.
  var isLoading = true.obs; // Yükleniyor durumu

  final cacheBox = Hive.box(Config.cacheMemory); // Cache için Hive kutusu

  @override
  void onInit() {
    super.onInit();
    getProfileImage();
  }

  // Firebase Storage'dan profil resmini almak
  Future<void> getProfileImage() async {
    try {
      isLoading(true);

      // Önce Hive cache kontrolü yap
      String? cachedUrl = cacheBox.get('profile_image_url');

      if (cachedUrl != null) {
        imageUrl.value = cachedUrl;
      }

      // Storage'dan yeni URL al ve cache’e kaydet
      final storageRef = FirebaseStorage.instance.ref().child(Config.profileImagePath);
      String newUrl = await storageRef.getDownloadURL();

      if (newUrl != cachedUrl) {
        cacheBox.put('profile_image_url', newUrl); // Yeni URL'yi cache’e ekle
        imageUrl.value = newUrl;
      }

    } catch (e) {
      errorMessage.value = 'Resim alınırken hata oluştu: $e';
      throw Exception(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
