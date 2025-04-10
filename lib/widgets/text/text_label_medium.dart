import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class TextLabelMedium extends StatelessWidget {
  const TextLabelMedium({super.key, required this.text, this.color, this.opacity, this.fontWeight});
  final String text;
  final Color? color;
  final double? opacity;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textThem.labelMedium!.copyWith( fontWeight: fontWeight, color:opacity != null ? context.textThem.labelMedium!.color!.withValues(alpha: opacity): color ),);
  }
}