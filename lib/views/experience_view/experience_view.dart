import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/experience_model.dart';
import 'package:portfolio/view-models/experience_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_title.dart';
import 'package:portfolio/widgets/text/index.dart';

class ExperienceView extends StatelessWidget {
   ExperienceView({super.key});

  final experienceController = Get.put(ExperienceController());
  final localeController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      experienceController.loadData(localeController.currentLanguageEnums.value);
    });

    return Obx(() {
            if (experienceController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = experienceController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, data);
          });
  }

  Widget body(BuildContext context, List<ExperienceModel> data)
  {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:  ConsPadding.onlyRightHalf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(title: LocaleKeys.general_experience.tr()),
                Padding(
                  padding: const ConsPadding.hSpace(),
                  child: Column(
                    children: List.generate(data.length, (index) => experienceItem(context, data[index])),
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: !(context.isMobile || context.isTabletV),
          child: AppSpacing().phoneLayer(context)
        )
      ],
    );
  }

  Widget experienceItem(BuildContext context, ExperienceModel item)
  {
    return Padding(
      padding: const ConsPadding.vSpace(),
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
                    TextHeadlineSmall(text:item.name,fontWeight: FontWeight.bold,),
                    AppSpacing.lowHeight,
                    TextTitleSmall(text:item.position, fontWeight: FontWeight.w400, opacity: .7,),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        TextBodyMedium(text:"${item.startYear} - ", fontStyle:  FontStyle.italic,),
                        TextBodyMedium(text:item.endYear.isEmpty ? (LocaleKeys.experience_page_present.tr()) : (item.endYear ), fontStyle:  FontStyle.italic,)              
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