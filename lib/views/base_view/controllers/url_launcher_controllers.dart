import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherController extends GetxController {
  var isHover = true.obs; // <-- .obs ekledik, artık reaktif!

  void launcherUrl(String url) async {
      final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not launch $url');
    }
  }
}
