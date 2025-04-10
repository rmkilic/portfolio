import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/constant/cons_size.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/enums/icon_enums.dart';
import 'package:portfolio/models/program_model.dart';
import 'package:portfolio/view-models/programs_controller.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/text/index.dart';


class ProjectsItem extends StatefulWidget {
  const ProjectsItem({super.key, required this.data});
  final ProgramModel data;
  @override
  State<ProjectsItem> createState() => _ProjectsItemState();
}

class _ProjectsItemState extends State<ProjectsItem> {
  final programController = Get.put(ProgramController());
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return project(widget.data);
  }


    Widget project( ProgramModel data)
  {
    return context.isMobile
    ? mobileCard( data)
    : desktopCard( data);
  }

  mobileCard( ProgramModel data)
  {
    double aspectRatio = data.aspectRatio == "9/16" ? 9/16 : 16/9;
    return InkWell(
      onTap: (){
    String imageUrl = programController.getCachedProfileImage(data) ?? "";
        
        showImagePopup(context, imageUrl);
      },
      child: Card(
        child:Padding(
          padding: const ConsPadding.allStandart(),
          child: Column(
          children: [
            SizedBox(
              height: 300,
              child: AspectRatio(aspectRatio: aspectRatio,
              child: image(data),),
            ),
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

  desktopCard(ProgramModel data)
  {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: ConsSize.space/2),
      child: InkWell(
        onTap: ()
        {
          programController.selectedProgram.value = data;
        },
        child: MouseRegion(
             onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
          child: Card(
            elevation: 10,
            shadowColor: isHovered ? context.dividerColor.withValues(alpha: .6) : null,
            child: Padding(
              padding: EdgeInsets.all(ConsSize.space/4),
              child: Row(
                         children: [
                           Expanded(child: image(data)),
                           const SizedBox(width: 10,),
                           Expanded(
                             flex: 4,
                             child: description(data))
                         ],
                       ),
            ),
          ),
        ),
      ),
    );

  }

  Widget image(ProgramModel data)
  {
    String imageUrl = programController.getCachedProfileImage(data) ?? "";
    return (data.images?? "").isEmpty ? const SizedBox() : Padding(
      padding: EdgeInsets.all(ConsSize.space),
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
    );
  }

  Widget description(ProgramModel data)
  {
    List<String> platforms = (data.platform??"").split('&');
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 300
        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextHeadlineSmall(text: data.name ?? "",fontWeight: FontWeight.bold), ),
                           
                            TextBodyLarge(text: data.description ?? ""),
                            featuresWidget(data.features ?? ""),
                            Row(
                              children: List.generate(platforms.length, (index)=> platformGenerate(platforms[index])),
                            )
                            
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

  Widget featuresWidget(String features)
  {
    List<String> featureList = features.split('-');
    featureList.removeAt(0);
    return Column(
      children: List.generate(featureList.length, (index) => featureItem(featureList[index]) ),
    );
  }
  Widget featureItem(String feature)
  {
    return ListTile(
      leading: Icon(IconEnums.substance.icon, ),
      title: TextBodyLarge(text:feature),
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