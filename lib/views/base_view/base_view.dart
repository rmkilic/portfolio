import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/view-models/scroll_view_model.dart';
import 'package:portfolio/views/about_view/about_view.dart';
import 'package:portfolio/views/base_view/widgets/custom_appbar.dart';
import 'package:portfolio/views/base_view/widgets/drawer.dart';
import 'package:portfolio/views/base_view/widgets/sidebar_widget.dart';
import 'package:portfolio/views/experience_view/experience_view.dart';
import 'package:portfolio/views/freelance/freelance_view.dart';
import 'package:portfolio/views/projects/projects_view.dart';
import 'package:portfolio/views/references_view/references_view.dart';
import 'package:portfolio/views/resume_view/resume_view.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/phone_widget.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  BaseViewState createState() => BaseViewState();
}

class BaseViewState extends State<BaseView> {
  final ScrollViewModel scrollViewModel = Get.put(ScrollViewModel());
      
  @override
  Widget build(BuildContext context) {
      double heightPhone= context.screenHeight*.8 < 800 ? 700 : context.screenHeight*.8;

    return  Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Visibility(
                  visible: MediaQuery.of(context).size.width >1000,
                  child: SizedBox(
                    //color: Colors.orange,
                    height: MediaQuery.of(context).size.height,
                    width: ConsSize.themeWidth,
                    child: SideBarWidget(),
                  )),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    controller: scrollViewModel.scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? context.paddingMobile : context.paddingDesktop),
                      child: Column(
                        children: [
                          aboutView(heightPhone),
                          AppSpacing.standartHeight,
                          experienceView(heightPhone),
                          AppSpacing.standartHeight,
                          referenceView(heightPhone),
                          AppSpacing.standartHeight,
                          resumeView(heightPhone),
                          AppSpacing.standartHeight,
                          projectsView(heightPhone),
                          AppSpacing.standartHeight,
                          freelancerView(heightPhone),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                      alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: !(context.isMobile || context.isTabletV),
                    child: Padding(
                      padding: EdgeInsets.only(right: context.isMobile ? context.paddingMobile : context.paddingDesktop),
                      child: PhoneWidget(),
                    )),
                )
              ],
            ),
          ),
         
         
        ],
      ),
      drawer: context.isMobile ?  DrawerWidget() : null,
    );
  }

  Widget  aboutView(double heightPhone)
  {
    return Container(
      key: scrollViewModel.aboutKey,
      padding: const ConsPadding.allSpace(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.isMobile ? 0 : heightPhone
        ),child: AboutPage()),
    );
  }

  Widget experienceView(double heightPhone)
  {
    return Container(
      key: scrollViewModel.experienceKey,
      padding: const ConsPadding.allSpace(),      
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.isMobile ? 0 : heightPhone
        ),child: ExperienceView()),
    );
  }

  Widget referenceView(double heightPhone)
  {
    return Container(
      key: scrollViewModel.referencesKey,
      padding: const ConsPadding.allSpace(),      
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.isMobile ? 0 : heightPhone
        ),
        child: ReferencesView()));
  }

  Widget resumeView(double heightPhone)
  {
    return Container(
      key: scrollViewModel.resumeKey,   
      padding: const ConsPadding.allSpace(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.isMobile ? 0 : heightPhone
        ),child: ResumeView())
    );
  }

  Widget projectsView(double heightPhone)
  {
    return Container(
      key: scrollViewModel.programsKey,
      padding: const ConsPadding.allSpace(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.isMobile ? 0 : heightPhone
        ),child: ProjectsView()));
  }

  Widget freelancerView(double heightPhone)
  {
    return Container(
      key: scrollViewModel.freelanceKey,
      padding: const ConsPadding.allSpace(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.isMobile ? 0 : heightPhone
        ),child: FreelanceView()));
  }

}
