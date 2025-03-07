import 'package:flutter/material.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/widgets/text/index.dart';

class HeaderSubTitle extends StatelessWidget {
  const HeaderSubTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  body(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:  EdgeInsets.symmetric(vertical:5.0),
            child: TextHeadlineSmall(text: title),
          ),
              SizedBox(
          width:  context.isMobile ? context.screenWidth*.15 : context.screenWidth*.04,
          height: 8,
          child: const Divider()
        ),
        SizedBox(
          height: ConsSize.space,
        ),
      ],
    );
  }
}