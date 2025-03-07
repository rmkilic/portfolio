import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/resume_model.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_sub_title.dart';
import 'package:portfolio/widgets/text/index.dart';

class ProfessionView extends StatelessWidget {
  const ProfessionView({super.key, required this.data});
  final Profession data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSubTitle(title: data.title),
        Column(
          children: List.generate(data.business.length, (index) => professionItem(context,data.business[index])),
        )
      ],
    );
  }

  Widget professionItem(BuildContext context, Business item)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitleMedium(text: item.name, fontWeight: FontWeight.bold),
          AppSpacing.lowHeight,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: context.dividerColor.withValues(alpha: .1),
            child: TextTitleSmall(text:item.year),
          ),
          AppSpacing.lowHeight,
          TextBodyLarge(text:item.company, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,),
          AppSpacing.standartHeight,
          professionAbout(item.description),
          AppSpacing.standartHeight,
          projects(context, item.project)
        ],
      ),
    );
  }

  Widget professionAbout(String desc)
  {
    List<String> list = desc.split('-');
    list.removeAt(0);
    return Column(
      children: List.generate(list.length, (index)=> listTile( list[index])),
    );
  }

  Widget projects(BuildContext context, List<Project> projects)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHeadlineSmall(text: LocaleKeys.general_projects.tr(),fontWeight: FontWeight.bold),
        AppSpacing.lowHeight,
        Column(
          children: List.generate(projects.length, (index)=> listTileV2(context, projects[index].name, projects[index].description)),
        )
      ],
    );
  }

   Widget listTile(String title)
  {
    return Padding(
      padding: const EdgeInsets.only(left:5.0, top: 5),
      child: Row(
        children: [
          Icon(IconEnums.substance.icon),
          Expanded(child: TextBodyLarge(text: title ))
        ],
          ),
    );
  }
  Widget listTileV2(BuildContext context, String title,String desc)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Icon(IconEnums.substance.icon),
      Expanded(child: 
      RichText(
        text: TextSpan(
      text: "$title: ",
      style: context.textThem.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      children:  <TextSpan>[
        TextSpan(text: desc, style: context.textThem.bodyLarge!.copyWith(color: context.textThem.bodyLarge!.color!.withValues(alpha: .9))),
        
      ],
        ),
      )
      )
        ],
          ),
    );
  }

}