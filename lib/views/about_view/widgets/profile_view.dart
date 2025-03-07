import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/view-models/profile_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_image.dart';
import 'package:portfolio/widgets/text/index.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.data});
  final AboutModel data;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController profileViewModel = Get.put(ProfileController());
  final LanguageController languageController = Get.put(LanguageController());



  @override
  Widget build(BuildContext context) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
    profileViewModel.loadData(languageController.currentLanguageEnums.value);
  });
      return Obx(() {
    if (profileViewModel.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    final profile = profileViewModel.data.value;
    if (profile == null) {
      return Center(child: Text("No data available"));
    }
            return context.isMobile
    ? mobileView( widget.data)
    : desktopView( widget.data);
          });
  
    
  }

    Widget desktopView( AboutModel data)
  {
    String? imagePath = profileViewModel.getCachedProfileImage(profileViewModel.data.value);

    return Padding(
      padding: EdgeInsets.symmetric(vertical:ConsSize.space),
      child: Column(
        children: [
          ProfileImage(imageUrl: imagePath ?? "",),
          AppSpacing.standartHeight,
          personal(data)
          
        ],
      ),
    );
  }
    Widget mobileView( AboutModel data)
  {
    String? imagePath = profileViewModel.getCachedProfileImage(profileViewModel.data.value);


    return SizedBox(
      height: 200,
      child: Padding(
        padding: const ConsPadding.hSpace(),
        child: Row(
          children: [
          ProfileImage(imageUrl: imagePath ?? "",),
            AppSpacing.standartWidth,
            AppSpacing.standartWidth,
            Expanded(child: personal(data))
            ],
        ),
      ),
    );
  }

  Widget personal(AboutModel data)
  {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextHeadlineSmall(text:LocaleKeys.general_name.tr(), overflow: TextOverflow.visible, fontWeight: FontWeight.bold,),
        TextBodyLarge(text: data.profession, overflow: TextOverflow.visible, fontWeight: FontWeight.bold, opacity: .5,),

      ],
    );
  }


}