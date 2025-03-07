import 'package:portfolio/core/constant/config.dart';

enum NetworkPathEnums {
  about,
  experience,
  program,
  freelance,
  reference,
  profile,
  document,
  resume;
}

extension ExtNetworkPath on NetworkPathEnums
{
  String get _path
  {
    switch(this)
    {
      case NetworkPathEnums.about:
        return "/about";
      case NetworkPathEnums.experience:
        return "/experience";
      case NetworkPathEnums.program:
        return "/programs";
      case NetworkPathEnums.freelance:
        return "/freelance";
      case NetworkPathEnums.reference:
        return "/references";
      case NetworkPathEnums.document:
        return "/document";
      case NetworkPathEnums.resume:
        return "/resume";
      case NetworkPathEnums.profile:
        return "/profile";

    }
  }
    String get getPath => "${Config.firebaseUrl}$_path";

}