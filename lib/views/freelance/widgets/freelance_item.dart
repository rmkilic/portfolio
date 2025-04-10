import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/freelance_model.dart';
import 'package:portfolio/view-models/freelance_controller.dart';
import 'package:portfolio/views/base_view/controllers/theme_controllers.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/text/index.dart';


class FreelanceItem extends StatefulWidget {
  const FreelanceItem({super.key, required this.data});
  final FreelanceModel data;
  @override
  State<FreelanceItem> createState() => _FreelanceItemState();
}

class _FreelanceItemState extends State<FreelanceItem> {
  final freelanceController = Get.put(FreelanceController());
  final themeController = Get.find<ThemeController>();

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
     return context.isMobile
    ? mobileCard(widget.data)
    : desktopCard(widget.data);
  }


  mobileCard(FreelanceModel data)
  {

    return InkWell(
      onTap: (){
    String imageUrl = freelanceController.getCachedProfileImage(data) ?? "";
        
        showImagePopup(context, imageUrl);
      },
      child: Card(
        child:Padding(
          padding: const ConsPadding.allStandart(),
          child: Column(
          children: [
            SizedBox(
              height: 300,
              child: AspectRatio(aspectRatio: 1,
              child: image(data),),
            ),
            title(data),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 200
              ),
              child: description(data))
          ],
              ),
        )
      ),
    );
  }

  Widget title(FreelanceModel data)
  {
    return Padding(
                padding: EdgeInsets.symmetric(vertical: ConsSize.space/2),
                child: Column(
                  children: [
                    TextHeadlineSmall(text: data.name,fontWeight: FontWeight.bold ),
                    AppSpacing.lowHeight,
                    TextTitleSmall(text: data.type == 1? LocaleKeys.general_freelance.tr() : LocaleKeys.general_personalProjects.tr(),opacity: .5, fontWeight: FontWeight.bold),               
                  ],
                ),
              );
  }

  desktopCard(FreelanceModel data)
  {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: ConsSize.space/2),
      child: Card(
        elevation: 10,
        shadowColor: isHovered ? context.dividerColor.withValues(alpha: .6) : null,
        child: Padding(
          padding: EdgeInsets.all(ConsSize.space/4),
          child: Column(
            children: [
              title(data),
              Row(
                         children: [
                           Expanded(child: image(data)),
                           const SizedBox(width: 10,),
                           Expanded(
                             flex: 4,
                             child: description(data))
                         ],
                       ),
            ],
          ),
        ),
      ),
    );

  }

  Widget image(FreelanceModel data)
  {
    String imageUrl = freelanceController.getCachedProfileImage(data) ?? "";
    return (data.image).isEmpty ? const SizedBox() : Padding(
      padding: EdgeInsets.all(ConsSize.space),
      child: CachedNetworkImage(
              color:  data.name == "Tane Tekstil" && ! themeController.isLightMode.value ? Colors.grey.shade700 : null,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              maxWidthDiskCache: 300, // Cache için maksimum genişlik
              maxHeightDiskCache: 300, // Cache için maksimum yükseklik
              placeholder: (context, url) => FittedBox(
                fit: BoxFit.contain,
                child: Icon(IconEnums.person.icon),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
    );
  }

   Widget description(FreelanceModel data)
  {
  
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 300
        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                           TextHeadlineSmall(text: data.title ,fontWeight: FontWeight.bold ),
                           TextBodyLarge(text: data.description),
                            featuresWidget(data.features),
                          
                            
                          ],
                        ),
                      );
  }
  platformGenerate(String platform)
  {
    IconData ? icon;
     if(platform.contains("Android"))
     {
        icon = IconEnums.android.icon;
     }
     else if(platform.contains("IOS"))
     {
      icon = IconEnums.ios.icon;
     }
     else
     {
      icon = IconEnums.web.icon;
     }
    return Padding(
      padding: ConsPadding.hSpace(),
      child: Row(
        children: [
          TextBodyMedium(text:platform.toUpperCase() ,fontWeight: FontWeight.bold),
          AppSpacing.lowWidth,
          Icon(icon)
        ],
      ),
    );
    
  }

  Widget featuresWidget(List<Feature> features)
  {
    
    return Column(
      children: List.generate(features.length, (index) => featureItem(features[index]) ),
    );
  }
  Widget featureItem(Feature feature)
  {
    return ListTile(
      leading: Icon(IconEnums.substance.icon, ),
      title: TextBodyLarge(text:feature.title),
    );
  }

    void showImagePopup(BuildContext context, String imagePath) {
      
    showDialog(
      context: context,
      barrierDismissible: true, // Dışarıya tıklanınca kapanır
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(ConsSize.space*2),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: InteractiveViewer(
                panEnabled: true, // Kaydırma aktif
                boundaryMargin: EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}