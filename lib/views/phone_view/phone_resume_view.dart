import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/models/resume_model.dart';
import 'package:portfolio/view-models/resume_controller.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_mobile.dart';
import 'package:portfolio/widgets/text/index.dart';

class PhoneResumeView extends StatelessWidget {
  PhoneResumeView({super.key, required this.profile});
  final ProfileModel profile;


  final resumeController = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
            if (resumeController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final about = resumeController.data.value;
            if (about == null) {
              return Center(child: Text("No data available"));
            }
            return resumeWidget(context, about);
          });
  }

    resumeWidget(BuildContext context, ResumeModel data)
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
                    child: TextHeadlineSmall(text:LocaleKeys.general_resume.tr())),
                    AppSpacing.lowHeight,
                TextBodyMedium(text: LocaleKeys.resume_page_downloadCVDescription.tr(),fontWeight: FontWeight.bold),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(onPressed: (){
                      resumeController.downloadFile(LanguageEnums.en);
                    }, style: ElevatedButton.styleFrom(backgroundColor: context.theme.scaffoldBackgroundColor,side: BorderSide(width: 1.0, color: context.dividerColor) ), child: 
                    TextBodyMedium(text:LocaleKeys.resume_page_english.tr()),),
                    AppSpacing.standartWidth,
                    ElevatedButton(onPressed: (){
                      resumeController.downloadFile(LanguageEnums.tr);

                    }, style: ElevatedButton.styleFrom(backgroundColor: context.theme.scaffoldBackgroundColor,side: BorderSide(width: 1.0, color: context.dividerColor)), child: 
                    TextBodyMedium(text:LocaleKeys.resume_page_turkish.tr())),
                  ],
                ),
                Spacer(),

                
              ],
            ),
          ),
        ),
      ))
    ;
  
  }
}