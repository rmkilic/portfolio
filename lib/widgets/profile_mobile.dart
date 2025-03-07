import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/view-models/profile_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/profile_image.dart';
import 'package:portfolio/widgets/text/index.dart';


class ProfileMobile extends StatefulWidget {
  const ProfileMobile({super.key});

  @override
  State<ProfileMobile> createState() => _ProfileMobileState();
}

class _ProfileMobileState extends State<ProfileMobile> {
final profileController = Get.put(ProfileController());

  final localeController = Get.find<LanguageController>();



@override
Widget build(BuildContext context) {
  

  WidgetsBinding.instance.addPostFrameCallback((_) {
    profileController.loadData(localeController.currentLanguageEnums.value);
  });

  return Obx(() {
    if (profileController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    final profile = profileController.data.value;
    if (profile == null) {
      return Center(child: Text("No data available"));
    }
            return body(context,profile);
          });
  }

  body(BuildContext context, ProfileModel data)
  {
    String? imagePath = profileController.getCachedProfileImage(profileController.data.value);


    return Visibility(
      visible: !context.isMobile,
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:ConsSize.space),

          child: Column(
            children: [
          ProfileImage(imageUrl: imagePath ?? ""),
          AppSpacing.standartHeight,
          personal(context, data),
             
          AppSpacing.standartHeight,

               
              Divider(),
            ],
          ),
        ),
      ))
    ;
  }

    Widget personal(BuildContext context, ProfileModel data)
  {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextHeadlineSmall(text:data.name, overflow: TextOverflow.visible,fontWeight: FontWeight.bold,),
        TextBodyLarge(text:data.profession, overflow: TextOverflow.visible, fontWeight: FontWeight.bold, opacity: .5,),
      ],
    );
  }
}