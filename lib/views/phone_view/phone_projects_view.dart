import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/models/program_model.dart';
import 'package:portfolio/view-models/programs_controller.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_mobile.dart';
import 'package:portfolio/widgets/text/index.dart';


class PhoneProjectsView extends StatelessWidget {
   PhoneProjectsView({super.key, required this.profile});
  final ProfileModel profile;


    final programController = Get.put(ProgramController());
  @override
  Widget build(BuildContext context) {

    return Obx(() {
            if (programController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = programController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, data);
          });
  }


    body(BuildContext context, List<ProgramModel> data)
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
          child: choiceWidget(context, data)
        ),
      ))
    ;
  }
  Widget choiceWidget(BuildContext context, List<ProgramModel> data){
    String imageUrl = "";
   return Obx(() {
          ProgramModel? selected = programController.selectedProgram.value;

          if (selected != null) {
            imageUrl = programController.getCachedProfileImage(selected) ?? "";
          }
      bool isContain = (selected?.aspectRatio ?? "9/16") == "16/9";
          return selected == null
              ? phoneWidget( data)
              : ClipRRect(
  borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit:  isContain? BoxFit.contain :  BoxFit.fill,
                    maxWidthDiskCache: 300,
                    maxHeightDiskCache: 300,
                    placeholder: (context, url) => FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(IconEnums.person.icon),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
              );
        });
  }

  Widget phoneWidget( List<ProgramModel> data)
  {
    return Padding(
            padding: const ConsPadding.allStandart(),
            child: Column(
              children: [
                ProfileMobile(),                
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextHeadlineSmall(text:LocaleKeys.general_projects.tr(),)),
                  
                AppSpacing.standartHeight,
                Expanded(
                  child: ListView(
                        children:List.generate(data.length, (index) => listItem(data[index])) ),
                      ),
              ],
            ),
          );
  }

  Widget listItem(ProgramModel data)
  {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:ConsSize.space/4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextBodyMedium(text: data.name ?? "", fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}