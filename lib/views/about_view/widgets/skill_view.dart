import 'package:flutter/material.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/models/about_model.dart';
import 'package:portfolio/widgets/text/index.dart';

class SkillView extends StatelessWidget {
  const SkillView({super.key, required this.data});
  final AboutModel data;

  @override
  Widget build(BuildContext context) {
    return ListView(
    children:generateSkills(context,data)  );
  }

  List<Widget> generateSkills(BuildContext context, AboutModel data)
  {
    return List.generate(data.skills.length, (index) => skillItem(context, data.skills[index]));
  }
  Widget skillItem(BuildContext context, Skill skill)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabelMedium(text:skill.name, fontWeight: FontWeight.bold),
              TextLabelMedium(text:"${skill.level}%", fontWeight: FontWeight.bold),
            ],
          ),
          const SizedBox(height: 2),
          TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            tween: Tween<double>(
              begin: 0,
              end: skill.level / 100,
            ),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 5,
                backgroundColor: context.dividerColor.withValues(alpha: .3),
                color: context.dividerColor,
              );
            },
          ),
        ],
      ),
    );
  }
}