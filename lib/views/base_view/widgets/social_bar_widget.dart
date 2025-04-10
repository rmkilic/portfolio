import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constant/config.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/views/base_view/controllers/url_launcher_controllers.dart';

class SocialBar extends StatelessWidget {
  const SocialBar({super.key});

  @override
  Widget build(BuildContext context) {
    final UrlLauncherController urlLauncherController = Get.find();

    return Column(
      children: [
        SocialIcon(icon: IconEnums.github.icon, callback: ()=> urlLauncherController.launcherUrl(Config.adressGithub)),
        SocialIcon(icon: IconEnums.linkedin.icon, callback: ()=> urlLauncherController.launcherUrl(Config.adressLinkedln)),
        SocialIcon(icon: IconEnums.mail.icon, callback: ()=> urlLauncherController.launcherUrl('mailto:${Config.adressEmail}')),
        Obx (()=> Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SizedBox(                            
            width: urlLauncherController.isHover.value ? 4 : 2,
            height: context.height *.2,
            child:  VerticalDivider(
              color: context.dividerColor.withValues(alpha: urlLauncherController.isHover.value ? 1 :.5),
            ),
          ),
        ),)
      ],
    );
  }
}

class SocialIcon extends StatefulWidget {
  const SocialIcon({super.key, required this.icon, required this.callback});
  final IconData icon;
  final VoidCallback callback;

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final UrlLauncherController urlLauncherController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: MouseRegion(
         onEnter: (_) 
         {
          isHovered = true;
          urlLauncherController.isHover.value = isHovered;
          setState(() {
          });
         },
          onExit: (_)
          {
            isHovered = false;
          urlLauncherController.isHover.value = isHovered;
          setState(() {
          });
          } ,
        child: IconButton(
          hoverColor: context.dividerColor.withValues(alpha: .2),
              icon: Icon(widget.icon, size: isHovered ? ConsSize.iconBigSize :  ConsSize.iconSize),
              onPressed: widget.callback,
            ),
      ),
    );
  }
}
