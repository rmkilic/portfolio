import 'package:flutter/material.dart';
import 'package:portfolio/views/base_view/widgets/language_widget.dart';
import 'package:portfolio/views/base_view/widgets/social_bar_widget.dart';


class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(children: [
              LanguageWidget(),
              Spacer(),
              SocialBar(),
          ],),
        );
      }
    );
  }
}

