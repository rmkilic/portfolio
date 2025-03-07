
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


extension BuildContextExtension<T> on BuildContext
{

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get deviceOSMobile => defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;

  bool get isMobile => this.screenWidth <1000 || deviceOSMobile;

  bool get isTabletV => this.screenWidth < 1600;
  double get paddingMobile => MediaQuery.of(this).size.width * .02;
  double get paddingDesktop => MediaQuery.of(this).size.width * .08;

  TextTheme get textThem => Theme.of(this).textTheme;

  Color get dividerColor => Theme.of(this).dividerTheme.color!;

}