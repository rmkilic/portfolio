import 'package:flutter/material.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class AppSpacing {
  static const Widget lowHeight = SizedBox(height: ConsSize.space/2);
  static const Widget standartHeight = SizedBox(height: ConsSize.space);

  static const Widget lowWidth = SizedBox(width: ConsSize.space/2);
  static const Widget standartWidth = SizedBox(width: ConsSize.space);

  static const Widget large = SizedBox(height: 24.0);
  Widget phoneLayer(BuildContext context) => SizedBox(width:  context.screenWidth *.2 < 400 ? 350 : context.screenWidth*.2);
}