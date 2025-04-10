import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/experience_model.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_mobile.dart';
import 'package:portfolio/widgets/text/index.dart';

import '../../view-models/experience_controller.dart';

class PhoneExperienceView extends StatelessWidget {
   PhoneExperienceView({super.key, required this.profile});
  final ProfileModel profile;

    final experienceController = Get.put(ExperienceController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
            if (experienceController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = experienceController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return experienceWidget(context, data);
          });
  }


  experienceWidget(BuildContext context, List<ExperienceModel> data)
  {
    return Visibility(
      visible: !context.isMobile,
      child: SizedBox(
        width: 400,
        child: Card(
          elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
          child: Padding(
            padding: const ConsPadding.allStandart(),
            child: Column(
              children: [
                ProfileMobile(),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextHeadlineSmall(text:LocaleKeys.general_experience.tr(),)),
                  
                AppSpacing.standartHeight,
                Expanded(
                  child: ListView(
                        children:List.generate(data.length, (index) => experienceItem(context, data[index])) ),
                      ),
                
               

              ],
            ),
          ),
        ),
      ))
    ;
  }
    Widget experienceItem(BuildContext context, ExperienceModel item)
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon( item.endYear.isEmpty ? IconEnums.circleDot.icon : IconEnums.circle.icon ,  color:  item.endYear.isEmpty ? context.dividerColor : context.dividerColor.withValues(alpha: .4),),
              AppSpacing.standartWidth,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitleMedium(text: item.name, fontWeight: FontWeight.bold,),
                    const SizedBox(height: 5,),
                    TextTitleSmall(text:item.position,fontWeight: FontWeight.w400, opacity: .7,),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("${item.startYear} - ",),
                        item.endYear.isEmpty ?
                        Text(LocaleKeys.experience_page_present).tr()
                        :Text(item.endYear)
                      
                
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
    );
  }

}