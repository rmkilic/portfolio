import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class TextHeadlineSmall extends StatelessWidget {
  const TextHeadlineSmall({super.key, required this.text, this.color, this.opacity, this.fontWeight, this.overflow});
  final String text;
  final Color? color;
  final double? opacity;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(text, overflow: overflow, style: context.textThem.headlineSmall!.copyWith( fontWeight: fontWeight, color:opacity != null ? context.textThem.headlineSmall!.color!.withValues(alpha: opacity): color ),);
  }
}