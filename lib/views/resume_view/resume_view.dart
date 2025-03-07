import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/resume_model.dart';
import 'package:portfolio/view-models/resume_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';
import 'package:portfolio/views/resume_view/widgets/education_view.dart';
import 'package:portfolio/views/resume_view/widgets/profession_view.dart';
import 'package:portfolio/views/resume_view/widgets/summary_view.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_title.dart';
import 'package:portfolio/widgets/text/index.dart';

class ResumeView extends StatelessWidget {
  ResumeView({super.key});


  final UrlLauncherController urlLauncheViewModel = Get.put(UrlLauncherController());
  final resumeController = Get.put(ResumeController());
  final localeController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      resumeController.loadData(localeController.currentLanguageEnums.value);
    });

    return Obx(() {
            if (resumeController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = resumeController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, data);
          });
  }

  Widget body(BuildContext context, ResumeModel data)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(title: LocaleKeys.general_resume.tr()),
        context.isMobile 
        ? mobileView(data)
        : desktopView(context, data)
      ],
    );
  }

  Widget desktopView(BuildContext context,ResumeModel data)
  {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:  ConsPadding.onlyRightHalf(context),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: LayoutBuilder(
                      builder: (context, constraint) {
                        return Column(                    
                          children: [
                            SummaryView(data: data.summary, layWidth: constraint.maxWidth,),
                            AppSpacing.standartHeight,
                            EducationView(dataList: data.education),
                          ],
                        );
                      }
                    )),
                    Expanded(child: ProfessionView(data: data.profession))
                  ],
                ),
                Visibility(
                  visible: context.isTabletV,
                  child: Padding(
                    padding: ConsPadding.vSpace(),
                    child: buttonColumn(context)
                  ))
            
              ],
            ),
          ),
        ),
        Visibility(
          visible:  !context.isTabletV,
          child: AppSpacing().phoneLayer(context))
      ],
    );
  }

  Widget mobileView(ResumeModel data)
  {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: [
              SummaryView(data: data.summary, layWidth: constraint.maxWidth,),
              AppSpacing.standartHeight,
              EducationView(dataList: data.education),
              AppSpacing.standartHeight,
              ProfessionView(data: data.profession),
              AppSpacing.standartHeight,
              buttonColumn(context)
          ],
        );
      }
    );
  }

  Widget buttonColumn(BuildContext context)
  {
    return Column(
      children: [
                TextBodyMedium(text: LocaleKeys.resume_page_downloadCVDescription.tr(), fontWeight: FontWeight.bold,),
              AppSpacing.standartHeight,          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               ElevatedButton(onPressed: ()=> resumeController.downloadFile(LanguageEnums.en),
                style: ElevatedButton.styleFrom(backgroundColor: context.theme.scaffoldBackgroundColor,side: BorderSide(width: 1.0, color: context.dividerColor) ), 
                child: TextBodyMedium(text:LocaleKeys.resume_page_english.tr(),),),
              AppSpacing.standartWidth,
              ElevatedButton(onPressed: ()=> resumeController.downloadFile(LanguageEnums.tr),
                style: ElevatedButton.styleFrom(backgroundColor: context.theme.scaffoldBackgroundColor,side: BorderSide(width: 1.0, color: context.dividerColor)), 
                child: TextBodyMedium(text:LocaleKeys.resume_page_turkish.tr(),)),     
            ],
          )
                
      ],
    );
  }




}