import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/view-models/profile_controller.dart';
import 'package:portfolio/view-models/scroll_view_model.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/phone_view/phone_about_view.dart';
import 'package:portfolio/views/phone_view/phone_experience_view.dart';
import 'package:portfolio/views/phone_view/phone_freelance_view.dart';
import 'package:portfolio/views/phone_view/phone_projects_view.dart';
import 'package:portfolio/views/phone_view/phone_references_view.dart';
import 'package:portfolio/views/phone_view/phone_resume_view.dart';

class PhoneWidget extends StatefulWidget {
  const PhoneWidget({super.key});

  @override
  State<PhoneWidget> createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
final ScrollViewModel scrollViewModel = Get.put(ScrollViewModel());


@override
Widget build(BuildContext context) {
  final profileController = Get.put(ProfileController());
  final localeController = Get.find<LanguageController>();

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
            return phoneWidget(profile);
          });
  }


    Widget phoneWidget(ProfileModel profile)
  {
    return Container(
      width:  context.screenWidth *.2 < 400 ? 350 : context.screenWidth*.2,
      height: context.screenHeight*.8 < 800 ? 700 : context.screenHeight*.8,
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E) ,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color:  Colors.black54 ,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color:  Colors.grey[700]!,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color:  Colors.black ,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const ConsPadding.allStandart(),
              child: activePage(profile),
            ),
          ),
        ],
      ),
    );
  }

Widget activePage(ProfileModel profile) {
  return Obx(() {
    // activeSectionKey değeri değiştiğinde widget'ı güncelle
    var key = scrollViewModel.activeSectionKey.value;

    if(key == null)
    {
      return PhoneAboutView(profile: profile,);
    }
    else
    {
      final sectionMap = {
      scrollViewModel.aboutKey: PhoneAboutView(profile: profile),
      scrollViewModel.experienceKey: PhoneExperienceView(profile: profile),
      scrollViewModel.referencesKey: PhoneReferencesView(profile: profile),
      scrollViewModel.resumeKey: PhoneResumeView(profile: profile),
      scrollViewModel.programsKey: PhoneProjectsView(profile: profile),
      scrollViewModel.freelanceKey: PhoneFreelanceView(profile: profile)
    };

    // Eğer key yoksa default olarak aboutWidget döner
    return sectionMap[key] ?? PhoneAboutView(profile: profile);
    }
    
  });
}

  


}