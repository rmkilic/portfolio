import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: 
        context.isMobile
        ? context.textThem.headlineMedium!.copyWith(fontWeight: FontWeight.bold)
        : context.textThem.headlineLarge!.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 
        context.isMobile
        ? 5
        : 10,),
        
        SizedBox(
          width:  context.isMobile ? context.screenWidth*.13 : context.screenWidth*.03,
          height: 10,
          child: const Divider()
        ),
        SizedBox(height: context.screenHeight * 0.05,),
      ],
    );
  }
}