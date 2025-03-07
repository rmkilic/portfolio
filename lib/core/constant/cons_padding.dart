import 'package:flutter/material.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';


class ConsPadding extends EdgeInsets{

  ///All - Standart Padding - ConsSize.space/2
  const ConsPadding.allStandart(): super.all(ConsSize.space/2);
  ///All - General Project Space - ConsSize.space
  const ConsPadding.allSpace(): super.all(ConsSize.space);

  ///Spacing with Phone Widget for desktop screens
   ConsPadding.onlyRightHalf(BuildContext context):super.only(right:context.isMobile? (context.paddingMobile/2) :(context.paddingDesktop/2));

  /// Horizontal space - ConsSize.space
  const ConsPadding.hSpace(): super.symmetric(horizontal: ConsSize.space);
  /// Horizontal low Space - ConsSize.space/2
  const ConsPadding.hLowSpace(): super.symmetric(horizontal: ConsSize.space/2);
  /// Vertical Space - ConsSize.space
  const ConsPadding.vSpace(): super.symmetric(vertical: ConsSize.space);


}