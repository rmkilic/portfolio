import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/init/lang/product_localization.dart';
import 'package:portfolio/enums/language_enums.dart';

class LanguageController extends GetxController {
  var currentLanguage = LanguageEnums.tr.languageCode.obs;
  var currentLocale = LanguageEnums.tr.localeCode.obs;
  var currentLanguageEnums = LanguageEnums.tr.obs;

  void changeLanguage(BuildContext context, LanguageEnums lang) {
    currentLanguage.value = lang.languageCode;
    currentLocale.value = lang.localeCode;  // Locale'yi güncelliyoruz
    currentLanguageEnums.value = lang;

    ProductLocalization.updateLanguage(context: context, value: lang);
   // EasyLocalization.of(context)?.setLocale(lang.localeCode); // EasyLocalization ile dil değiştirme
  }
}

