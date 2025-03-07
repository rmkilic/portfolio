import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class TextTitleMedium extends StatelessWidget {
  const TextTitleMedium({super.key, required this.text, this.color, this.opacity, this.fontWeight});
  final String text;
  final Color? color;
  final double? opacity;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textThem.titleMedium!.copyWith( fontWeight: fontWeight, color:opacity != null ? context.textThem.titleMedium!.color!.withValues(alpha: opacity): color ),);
  }
}