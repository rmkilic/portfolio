import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/models/references_model.dart';
import 'package:portfolio/view-models/references_controller.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_image.dart';
import 'package:portfolio/widgets/profile_mobile.dart';
import 'package:portfolio/widgets/text/index.dart';

class PhoneReferencesView extends StatelessWidget {
  PhoneReferencesView({super.key, required this.profile});
  final ProfileModel profile;


    final referencesController = Get.put(ReferencesController());
    final UrlLauncherController urlLauncheViewModel = Get.put(UrlLauncherController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
            if (referencesController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = referencesController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return referencesWidget(context, data);
          });
  }


  Widget referencesWidget(BuildContext context, List<ReferencesModel> data)
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
                    child: TextHeadlineSmall(text:LocaleKeys.general_references.tr())),
                    
          
                  Expanded(
                    child: ListView(
                          children:List.generate(data.length, (index) => referencesItem(context, data[index])) ),
                        ),
                  
                  

                ],
              ),
            ),
          ),
        ));
  }
  Widget referencesItem(BuildContext context, ReferencesModel item)
  {
    String? imageUrl = referencesController.getCachedProfileImage(item);
    return     Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 90,
                  width: 70,
                  child: ProfileImage(imageUrl: imageUrl ?? "")),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitleMedium(text: item.name, fontWeight: FontWeight.bold),
                      AppSpacing.lowHeight,                      
                      listTile(context, item.phone),
                      listTile(context, item.linkedin, isLink: true),                  
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.standartHeight,
            TextTitleSmall(text: item.position, fontWeight: FontWeight.bold,),
          ],
        ),
      ),
    );
  }

  Widget listTile(BuildContext context, String title,{bool isLink = false})
  {
    return Padding(
      padding: const EdgeInsets.only(left:10.0, top: 5),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap:  isLink ? (){
          onTap(title);
        } : null,
        child: Row(
          children: [
            Icon(isLink ? IconEnums.linkedin.icon : IconEnums.phone.icon),
            AppSpacing.standartWidth,
            Expanded(child: TextBodyMedium(text:title , color: isLink ? context.dividerColor : null,))
          ], 
            ),
      ),
    );
  }

  void onTap(String link)
  {
    urlLauncheViewModel.launcherUrl("https://www.$link");
  }
}