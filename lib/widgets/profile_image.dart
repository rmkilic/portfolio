/* import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/view-models/profile_image_view_model.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({super.key});

  final ProfileImageViewModel profileViewModel = Get.put(ProfileImageViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileViewModel.isLoading.value) {
        return const CircularProgressIndicator(); // Yüklenme göstergesi
      }

      if (profileViewModel.errorMessage.isNotEmpty) {
        return Text(profileViewModel.errorMessage.value); // Hata mesajı
      }

      return Container(
        width: 120.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: profileViewModel.imageUrl.value,
            fit: BoxFit.cover,
            maxWidthDiskCache: 300, // Cache için maksimum genişlik
            maxHeightDiskCache: 300, // Cache için maksimum yükseklik
            placeholder: (context, url) => FittedBox(
              fit: BoxFit.contain,
              child: Icon(IconEnums.person.icon),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
    });
  }
}


 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/enums/icon_enums.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageUrl});
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
   


      return Container(
        width: 120.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .3),
              blurRadius: 10.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            maxWidthDiskCache: 300, 
            maxHeightDiskCache: 300,
            placeholder: (context, url) => FittedBox(
            fit: BoxFit.contain,
            child: Icon(IconEnums.person.icon),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
   
  }
}


