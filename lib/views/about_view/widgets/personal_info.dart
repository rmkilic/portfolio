import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/widgets/header_sub_title.dart';
import 'package:portfolio/widgets/text/index.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key, required this.data});
  final AboutModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSubTitle(title: LocaleKeys.about_page_personalInfo.tr(),),
        context.isMobile
        ? mobilePersonalInfo(data)
        : desktopPersonalInfo(data)
      ],
    );
  }

  Widget mobilePersonalInfo( AboutModel data)
  {
    return Column(
      children: [
        personalInfo( title: LocaleKeys.about_page_birthday, value: data.birthday),
        personalInfo( title: LocaleKeys.about_page_degree, value: data.degree),
        personalInfo( title: LocaleKeys.about_page_militaryService, value: data.militaryService),
        personalInfo( title: LocaleKeys.about_page_drivingLicence, value: data.drivingLicence),
        personalInfo( title: LocaleKeys.about_page_phone, value: data.phone),
        personalInfo( title: LocaleKeys.about_page_eMail, value: data.email),
        personalInfo( title: LocaleKeys.about_page_freelance, value: data.freelance),
        personalInfo( title: LocaleKeys.about_page_city, value: data.city),
      ],
    );

  }

    Widget desktopPersonalInfo(AboutModel data)
   {
    return   Padding(
      padding: const EdgeInsets.only(left:20.0),
      child: Column(
        children: [          
          desktopPersonalInfoRow(title1: LocaleKeys.about_page_birthday, value1: data.birthday, title2: LocaleKeys.about_page_degree, value2: data.degree ),
          desktopPersonalInfoRow(title1: LocaleKeys.about_page_militaryService, value1: data.militaryService, title2: LocaleKeys.about_page_drivingLicence, value2: data.drivingLicence ),
          desktopPersonalInfoRow(title1: LocaleKeys.about_page_phone, value1: data.phone, title2: LocaleKeys.about_page_eMail, value2: data.email ),
          desktopPersonalInfoRow(title1: LocaleKeys.about_page_freelance, value1: data.freelance, title2: LocaleKeys.about_page_city, value2: data.city ),
        ],
      ),
    );
   }

   Widget desktopPersonalInfoRow({required String title1, required String value1, required String title2, required String value2})
   {
    return Row(
            children: [
              Expanded(child: personalInfo( title: title1, value: value1),),
              Expanded(child: personalInfo( title: title2, value: value2),),  
            ],
          );
   }

    Widget personalInfo({required String title, required String value})
   {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        Icon(IconEnums.substance.icon),
        TextBodyLarge(text: title.tr(), fontWeight: FontWeight.bold,),
        TextBodyLarge(text:":", fontWeight: FontWeight.bold,),
        const SizedBox(width: 10,),
        Expanded(child: TextBodyLarge(text:value.tr(),  overflow: TextOverflow.ellipsis),)      
      ],),
    );
   }
}