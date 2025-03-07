import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class TextBodyLarge extends StatelessWidget {
  const TextBodyLarge({super.key, required this.text, this.color, this.opacity, this.fontWeight, this.textAlign, this.overflow, this.fontStyle});
  final String text;
  final Color? color;
  final double? opacity;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, overflow: overflow, style: context.textThem.bodyLarge!.copyWith(fontStyle: fontStyle, fontWeight: fontWeight, color:opacity != null ? context.textThem.bodyLarge!.color!.withValues(alpha: opacity): color ),);
  }
}