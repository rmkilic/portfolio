import 'package:flutter/material.dart';

///Project Supported Locale Enums
enum LanguageEnums
{
  ///Turkish Locale
  tr(localeCode: Locale('tr','TR')  , languageCode: 'tr', countryCode: 'tr'),
  ///English Locale
  en(localeCode: Locale('en','US')  , languageCode: 'en', countryCode: 'us');


  const LanguageEnums({
    required this.languageCode,
    required this.countryCode,
    required this.localeCode

  });
  /// For language
  final String languageCode;
  /// For Flag
  final String countryCode; 
  final Locale localeCode;
  
}
extension ExtLanguage on LanguageEnums
{
  String get path
  {
    switch(this)
    {
      case LanguageEnums.tr:
        return "/tr.json";
      case LanguageEnums.en:
        return "/en.json";
    }
  }
}