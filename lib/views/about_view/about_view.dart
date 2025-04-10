import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/view-models/about_controller.dart';
import 'package:portfolio/views/about_view/widgets/personal_info.dart';
import 'package:portfolio/views/about_view/widgets/profile_view.dart';
import 'package:portfolio/views/about_view/widgets/skill_view.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_sub_title.dart';
import 'package:portfolio/widgets/header_title.dart';
import 'package:portfolio/widgets/text/index.dart';


class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  final aboutController = Get.put(AboutController());
  final localeController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    

    WidgetsBinding.instance.addPostFrameCallback((_) {
      aboutController.loadData(localeController.currentLanguageEnums.value);
    });

    return Obx(() {
            if (aboutController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final about = aboutController.data.value;
            if (about == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, about);
          });
  }

  Widget body(BuildContext context, AboutModel data)
  {
    return context.isMobile 
    ? mobileView(context, data)
    : desktopView(context, data);
    
  }

  Widget mobileView(BuildContext context, AboutModel data)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        mobilePersonalInfo(data),
        AppSpacing.standartHeight,
        aboutDescription(data),
        AppSpacing.standartHeight,
        PersonalInfo(data: data,),
        AppSpacing.standartHeight,
        HeaderSubTitle(title: LocaleKeys.about_page_skills.tr(),),
        Column(
          children: SkillView(data: data).generateSkills(context, data),
        )
      ],
    );
  }

  Widget mobilePersonalInfo(AboutModel data)
  {
    return Card(
      elevation: 4,
      child: ProfileView(data: data),
    );
  }

  Widget desktopView(BuildContext context, AboutModel data)
  {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:  ConsPadding.onlyRightHalf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                desctopDescription(data),
                Visibility(
                  visible: context.isTabletV,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderSubTitle(title: LocaleKeys.about_page_skills.tr(),),
                      SizedBox(
                        height: (data.skills.length/2).ceil() * 50,
                        child: Padding(
                          padding: ConsPadding.hSpace(),
                          child: Wrap(
                            spacing: ConsSize.space,
                           children:  List.generate(data.skills.length, (index) => SizedBox(
                            width: context.width*.3,
                            height: 50,
                            child:SkillView(data: data).skillItem(context, data.skills[index]))
                           ), 
                           ),
                        ),
                      )
       
                    ],
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
  Widget get title => HeaderTitle(title: LocaleKeys.general_about.tr(),);
  
  Widget aboutDescription(AboutModel data) =>TextBodyLarge(text: data.description, textAlign: TextAlign.justify,);


  desctopDescription(AboutModel data)
  {
    return Padding(
                padding: const ConsPadding.allSpace(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [                   
                    aboutDescription(data),
                    AppSpacing.standartHeight,
                    PersonalInfo(data: data,),
                  ],
                ),
              );
  }






}

