import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/models/freelance_model.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/view-models/freelance_controller.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_mobile.dart';
import 'package:portfolio/widgets/text/index.dart';

class PhoneFreelanceView extends StatelessWidget {
   PhoneFreelanceView({super.key, required this.profile});
  final ProfileModel profile;


    final freelanceController = Get.put(FreelanceController());
  @override
  Widget build(BuildContext context) {

    return Obx(() {
            if (freelanceController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = freelanceController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, data);
          });
  }


  body(BuildContext context, List<FreelanceModel> data)
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
                  child: TextHeadlineSmall(text:LocaleKeys.general_freelanceAndPersonal.tr())),
                  
                AppSpacing.standartHeight,
                Expanded(
                  child: ListView(
                        children:List.generate(data.length, (index) => listItem(data[index])) ),
                      ),
                
               

              ],
            ),
          )
        ),
      ))
    ;
  }

  Widget listItem(FreelanceModel data)
  {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:ConsSize.space/4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBodyMedium(text:data.name, fontWeight: FontWeight.bold,),
              AppSpacing.lowHeight,
              TextTitleSmall(text: data.type == 1? LocaleKeys.general_freelance.tr() : LocaleKeys.general_personalProjects.tr(),opacity: .5, fontWeight: FontWeight.bold), 
            ],
          ),
        ),
      ),
    );
  }
}