import 'package:flutter/material.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/models/resume_model.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_sub_title.dart';
import 'package:portfolio/widgets/text/index.dart';

class EducationView extends StatelessWidget {
  const EducationView({super.key, required this.dataList, required this.width});
  final List<Education> dataList;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSubTitle(title: dataList.first.title),
          AppSpacing.lowHeight,
          Column(
            children: List.generate(dataList.length, (index) => educationItem(context, dataList[index])),
          )
        ],
      ),
    );
  }


  Widget educationItem(BuildContext context, Education item)
  {
    return Padding(
      padding: const ConsPadding.vSpace(),
      child: Row(
            children: [
              AppSpacing.standartWidth,
              educationDesc(context, item)
            ],
          ),
    );
  }

  Widget educationDesc(BuildContext context, Education item)
  {
    return  SizedBox(
      width: width - (context.isMobile? (context.paddingMobile/2) :(context.paddingDesktop/2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitleMedium(text: item.name,fontWeight: FontWeight.bold ),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: context.dividerColor.withValues(alpha: .1),
            child: TextTitleSmall(text:item.year, fontWeight: FontWeight.bold,),
          ),
          const SizedBox(height: 5,),
          TextBodyLarge(text:item.school, maxlines: 1, overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}