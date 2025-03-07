import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/references_model.dart';
import 'package:portfolio/view-models/references_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_title.dart';
import 'package:portfolio/widgets/profile_image.dart';
import 'package:portfolio/widgets/text/index.dart';

class ReferencesView extends StatelessWidget {
  ReferencesView({super.key});


  final UrlLauncherController urlLauncheViewModel = Get.put(UrlLauncherController());

  final referencesController = Get.put(ReferencesController());
  final localeController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      referencesController.loadData(localeController.currentLanguageEnums.value);
    });

    return Obx(() {
            if (referencesController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = referencesController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, data);
          });
  }

  Widget body(BuildContext context, List<ReferencesModel> data)
  {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:  ConsPadding.onlyRightHalf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(title: LocaleKeys.general_references.tr()),
                Padding(
                  padding: const ConsPadding.hLowSpace(),
                  child: Column(
                    children: List.generate(data.length, (index) => listItem(context, data[index])),
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: !(context.isMobile ||context.isTabletV),
          child: AppSpacing().phoneLayer(context)
        )
      ],
    );
  }

  Widget listItem(BuildContext context, ReferencesModel item)
  {
    String?  imageUrl =referencesController.getCachedProfileImage(item);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        child: Row(
          children: [
            ProfileImage(imageUrl: imageUrl ?? ""),
            AppSpacing.standartWidth,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitleMedium(text: item.name,fontWeight: FontWeight.bold),
                  AppSpacing.lowHeight,
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextTitleSmall(text:item.position,fontWeight: FontWeight.bold,),
                  ),
                  listTile(context, item.phone),
                  listTile(context, item.linkedin, isLink: true),              
                ],
              ),
            ),
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
            Icon(IconEnums.substance.icon),
            Expanded(child: TextBodyMedium(text: title , color: isLink ? context.dividerColor : null,))
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