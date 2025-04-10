import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/view-models/about_controller.dart';
import 'package:portfolio/views/about_view/widgets/profile_view.dart';
import 'package:portfolio/views/about_view/widgets/skill_view.dart';
import 'package:portfolio/widgets/text/index.dart';

class PhoneAboutView extends StatelessWidget {
  PhoneAboutView({super.key, required this.profile});
  final ProfileModel profile;
  final aboutController = Get.put(AboutController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
            if (aboutController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final about = aboutController.data.value;
            if (about == null) {
              return Center(child: Text("No data available"));
            }
            return aboutWidget(context, about);
          });
  }

  aboutWidget(BuildContext context, AboutModel data)
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
                ProfileView(data:data),
                Divider(),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextHeadlineSmall(text:LocaleKeys.about_page_skills.tr(),)),
                Expanded(
                  child: SkillView(data: data,)
                      ),
              ],
            ),
          ),
        ),
      ))
    ;
  
  }



}