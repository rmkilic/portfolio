import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class TextTitleSmall extends StatelessWidget {
  const TextTitleSmall({super.key, required this.text, this.color, this.opacity, this.fontWeight, this.letterSpacing});
  final String text;
  final Color? color;
  final double? opacity;
  final FontWeight? fontWeight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textThem.titleSmall!.copyWith(letterSpacing: letterSpacing, fontWeight: fontWeight, color:opacity != null ? context.textThem.titleSmall!.color!.withValues(alpha: opacity): color ),);
  }
}