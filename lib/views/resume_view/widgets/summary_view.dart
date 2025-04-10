import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/config.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/resume_model.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_sub_title.dart';
import 'package:portfolio/widgets/text/index.dart';


class SummaryView extends StatelessWidget {
  SummaryView({super.key, required this.data, required this.layWidth});
  final Summary data;
  final double layWidth;

  final UrlLauncherController urlLauncheViewModel = Get.put(UrlLauncherController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderSubTitle(title: data.title),
        description(context, data)

      ],
    );
  }



  Widget description(BuildContext context, Summary summary)
  {
    return Padding(
      padding: ConsPadding.hSpace(),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitleMedium(text: summary.name, fontWeight: FontWeight.bold),
              AppSpacing.standartHeight,
              SizedBox(
                width:  layWidth -  (ConsSize.space *2),
                child: TextBodyLarge(text:summary.about)),          
              AppSpacing.lowHeight,
               SizedBox(
                width:  layWidth -  (ConsSize.space * 2) ,      
                child: contact(context, summary.contact)),              
            ],
          ),
    );
  }
  Widget contact(BuildContext context, Contact contact)
  {
    return Column(
      
      children: [
        listItem(context, contact.city),
        listItem(context, contact.phone),
        listItem(context, contact.email),
        listItem(context, contact.github, isLink: true, linkAdress: Config.adressGithub),
        listItem(context, contact.linkedin, isLink: true, linkAdress: Config.adressLinkedln)
      ],
    );
  }

  Widget listItem(BuildContext context, String title,{bool isLink = false, String linkAdress = ""})
  {
    return Padding(
      padding: const EdgeInsets.only(left:5.0, top: 5),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap:  isLink ? (){
          urlLauncheViewModel.launcherUrl(linkAdress);
        } : null,
        child: Row(
          children: [
            Icon(IconEnums.substance.icon),
            Expanded(child: TextBodyLarge(text: title, color: isLink ? context.dividerColor : null))
          ],
            ),
      ),
    );
  }
}