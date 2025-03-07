import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/view-models/scroll_view_model.dart';
import 'package:portfolio/views/base_view/widgets/language_combobox.dart';
import 'package:portfolio/views/base_view/widgets/theme_widget.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/text/index.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {


   CustomAppBar({super.key});

    List<String> tabMenuItem = [
      LocaleKeys.general_about,
      LocaleKeys.general_experience,
      LocaleKeys.general_references,
      LocaleKeys.general_resume,
      LocaleKeys.general_projects
    ];
  

  @override
  Widget build(BuildContext context) {
    return context.isMobile 
    ? mobileView
    : desktopView;
  }
  AppBar get mobileView
  {
    return AppBar(
      actions: [
        ThemeWidget(),
        AppSpacing.standartWidth,
        LanguageCombobox(),
        AppSpacing.lowWidth
      ],
      
    );
  }

  Widget get desktopView
  {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          ThemeWidget(),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _tabs,
          ))
        ],
      ),
    );
  }
    

  List<Widget> get _tabs
  {
    return 
    List.generate(tabMenuItem.length, (int index)=>Tab(child: FittedBox(child: _AppbarItem(text: tabMenuItem[index], index: index)),));
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}



class _AppbarItem extends StatefulWidget {
  const _AppbarItem({required this.text, required this.index});
  final String text;
  final int index;

  @override
  State<_AppbarItem> createState() => _BaseViewState();
}

class _BaseViewState extends State<_AppbarItem> {
  bool isHovered = false;
  final ScrollViewModel scrollViewModel = Get.put(ScrollViewModel());



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        scrollViewModel.scrollToSection(getGlobalKey);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:30.0),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: TextTitleSmall(text:widget.text.tr().toUpperCase(), color: isHovered ? context.dividerColor: context.textThem.titleSmall!.color!.withValues(alpha: .7),
            letterSpacing: 2.0,
            fontWeight: isHovered ? FontWeight.bold : FontWeight.w400,)),
      ));
  }


  GlobalKey<State<StatefulWidget>> get getGlobalKey
  {
    switch(widget.index)
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

}


