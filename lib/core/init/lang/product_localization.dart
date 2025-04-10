import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/enums/language_enums.dart';


@immutable
///Product Localization Manager
final class ProductLocalization extends EasyLocalization
{
  ProductLocalization({required super.child, super.key}): 
  super(supportedLocales:  _supportedLocales, 
  path: _translationPath,
  useOnlyLangCode: true
  );


    static final List<Locale> _supportedLocales = [
    LanguageEnums.tr.localeCode,
    LanguageEnums.en.localeCode,
    //LanguageEnums.de.localeCode
  ];

  static const String _translationPath = "assets/translations";

  static void updateLanguage({required BuildContext context, required LanguageEnums value,}) {
    context.setLocale(value.localeCode);
  }

}