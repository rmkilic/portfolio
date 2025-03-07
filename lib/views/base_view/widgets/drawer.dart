

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/config.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/profile_model.dart';
import 'package:portfolio/view-models/profile_controller.dart';
import 'package:portfolio/view-models/scroll_view_model.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';
import 'package:portfolio/widgets/profile_image.dart';
import 'package:portfolio/widgets/text/index.dart';


class DrawerWidget extends StatefulWidget {
   const DrawerWidget({super.key, });

  @override
  State<DrawerWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {

    final profileController = Get.put(ProfileController());
    
  final UrlLauncherController urlLauncheViewModel = Get.put(UrlLauncherController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: 
      
      Column(
        children: [
          _drawerHeader,
          Expanded(
            child: ListView(
              children: _tabs,
            ),
          ),
          
        ]
      ),
    );
  }

  Widget get _drawerHeader
  {
    ProfileModel ? data = profileController.data.value;
    String? imagePath = profileController.getCachedProfileImage(profileController.data.value);

    return SizedBox(
            height: context.screenHeight *.4  < 330? 330 : context.screenHeight*.4,
            
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical:ConsSize.space),
                  child: ProfileImage(imageUrl:  imagePath ?? "",),
                ),
                TextBodyMedium(text:data?.name ?? "",fontWeight: FontWeight.bold),
                TextBodySmall(text: data?.profession ?? "", overflow: TextOverflow.visible,fontWeight: FontWeight.bold, opacity: .5,),
                SizedBox(
                  height: ConsSize.space,
                ),
                _links
              ],
            ),
          );
  }



  Widget get _links
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _linkItem(icon: IconEnums.github.icon, onTap: _openGithub),
                    _linkItem(icon: IconEnums.linkedin.icon, onTap: _openLinkedln),
                    _linkItem(icon: IconEnums.mail.icon, onTap: _openMail),                      
                  ],
                );
  }

  _linkItem({required IconData icon, required VoidCallback? onTap})
  {
    return Padding(
      padding: const ConsPadding.allStandart(),
      child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: context.dividerColor.withValues(alpha: .2)),
              child: Icon(icon, size: ConsSize.iconSize,),
              ),
        ),
    );
  }

  _openGithub()=> urlLauncheViewModel.launcherUrl(Config.adressGithub);

  _openLinkedln()=> urlLauncheViewModel.launcherUrl(Config.adressLinkedln);

  _openMail()=> urlLauncheViewModel.launcherUrl('mailto:${Config.adressEmail}');


    List<String> tabMenuItem = [
    LocaleKeys.general_about,
    LocaleKeys.general_experience,
    LocaleKeys.general_references,
    LocaleKeys.general_resume,
    LocaleKeys.general_projects
  ];

  List<Widget> get _tabs
  {
    return 
    List.generate(tabMenuItem.length, (int index)=> CustomTabItem(index: index,));
  }



}


class CustomTabItem extends StatelessWidget {
   CustomTabItem({super.key, required this.index,});
  final int index;

  final ScrollViewModel scrollViewModel = Get.put(ScrollViewModel());


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const ConsPadding.allStandart(),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
        scrollViewModel.scrollToSection(getGlobalKey);

              
                },
                child: ListTile(
                  leading: Icon(_getIcon(index),),
                  title: Text(tabMenuItem[index].tr(),),
                ),
              ),              
            ],
          ),
    );
  }
    IconData _getIcon(int index)
  {
    switch(index)
    {
      case 0:
        return IconEnums.about.icon;
      case 1:
        return IconEnums.experience.icon;
      case 2:
        return IconEnums.resume.icon;
      case 3:
        return IconEnums.projects.icon;
      default:
        return IconEnums.skipNext.icon;
    }
  }

GlobalKey<State<StatefulWidget>> get getGlobalKey
  {
    switch(index)
    {
     
      case 1:
        return scrollViewModel.experienceKey;
      case 2:
        return scrollViewModel.referencesKey;
      case 3:
        return scrollViewModel.resumeKey;
      case 4:
        return scrollViewModel.programsKey;
       default:
        return scrollViewModel.aboutKey;
    }
  }

     final List<String> tabMenuItem = [
    LocaleKeys.general_about,
    LocaleKeys.general_experience,
    LocaleKeys.general_references,
    LocaleKeys.general_resume,
    LocaleKeys.general_projects
  ];
  }
