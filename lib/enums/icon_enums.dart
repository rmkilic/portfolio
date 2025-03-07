import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum IconEnums
{
  circleDot(icon: FontAwesomeIcons.circleDot),
  circle(icon: FontAwesomeIcons.circle),
  person(icon: FontAwesomeIcons.userTie),
  substance(icon: Icons.arrow_right),
  about(icon: FontAwesomeIcons.user),
  experience(icon: FontAwesomeIcons.briefcase),
  resume(icon: FontAwesomeIcons.fileLines),
  projects(icon: Icons.layers_outlined),
  github(icon: FontAwesomeIcons.github),
  linkedin(icon: FontAwesomeIcons.linkedin),
  mail(icon: Icons.mail_outline),
  topIcon(icon: Icons.change_history),
  skipNext(icon: Icons.skip_next),
  phone(icon: Icons.phone),
  android(icon: FontAwesomeIcons.googlePlay),
  ios(icon: FontAwesomeIcons.appStoreIos),
  web(icon: Icons.language),
  instagram(icon: FontAwesomeIcons.instagram);
  const IconEnums({
    required this.icon
  });
  final IconData icon;
}