import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/instance_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portfolio/core/constant/config.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/services/firebase_service.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/base_view/controllers/theme_controllers.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';


class Injection {
  static Future<void> initialize() async{
    await _easyLocalization();
    _dio(); 
    await _cachedMemory();
    await _firebase();
    _services();
    globalController();

  }

  // Dio için bağımlılık kaydını yapıyoruz
  static void _dio()=> GetIt.instance.registerLazySingleton<Dio>(() => Dio());
  


  // FirebaseService için bağımlılık kaydını yapıyoruz
  static void _services() => GetIt.instance.registerLazySingleton<FirebaseService>(
      () => FirebaseService(dio: GetIt.instance<Dio>()),
    );
  

  static Future<void> _cachedMemory()async
  {
      await Hive.initFlutter(); 
      await Hive.openBox(Config.cacheMemory); 
  }

static Future<void> _firebase()async=>await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);



static Future<void> _easyLocalization()async=> await EasyLocalization.ensureInitialized();  // EasyLocalization'ı başlat


static void globalController()
{
  Get.put(ThemeController());
  Get.put(LanguageController());
  Get.put(UrlLauncherController());
}




}
