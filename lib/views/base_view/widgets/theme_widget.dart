import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/enums/animation_enums.dart';
import 'package:portfolio/views/base_view/controllers/theme_controllers.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2), value: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _controller.animateTo(themeController.isLightMode.value ? 0.5 : 1);
            themeController.toggleTheme();
          },
          child: SizedBox(
            height: context.isMobile ? 30.0 : 50.0,
            width: context.isMobile ? ((ConsSize.themeWidth/5)*3) : ConsSize.themeWidth,
            child: Lottie.asset(
              controller: _controller,
              AnimationEnums.theme.toPath,
            ),
          ),
        );
      },
    );
  }
}
