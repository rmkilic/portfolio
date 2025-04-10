import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class TextBodySmall extends StatelessWidget {
  const TextBodySmall({super.key, required this.text, this.color, this.opacity, this.fontWeight, this.textAlign, this.overflow, this.fontStyle});
  final String text;
  final Color? color;
  final double? opacity;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, overflow: overflow, style: context.textThem.bodySmall!.copyWith(fontStyle: fontStyle, fontWeight: fontWeight, color:opacity != null ? context.textThem.bodySmall!.color!.withValues(alpha: opacity): color ),);
  }
}