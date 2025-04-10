import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/init/injection.dart';
import 'package:portfolio/core/init/lang/product_localization.dart';
import 'package:portfolio/core/init/theme/custom_dark_theme.dart';
import 'package:portfolio/core/init/theme/custom_light_theme.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/views/base_view/base_view.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/base_view/controllers/theme_controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.initialize();  
  runApp(
    ProductLocalization(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeController = Get.find<ThemeController>();
  final languageController = Get.find<LanguageController>();



@override
Widget build(BuildContext context) {

    LanguageEnums localeLanguage = LanguageEnums.values.where((e) => e.localeCode == context.locale).toList().first;
    languageController.changeLanguage(context, localeLanguage);
    return Obx(() => MaterialApp(
      title: 'RMK CV',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,      
      themeMode:  themeController.isLightMode.value ? ThemeMode.light : ThemeMode.dark,
      home:   BaseView(),
    ));
}

}