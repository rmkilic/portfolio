import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/models/program_model.dart';
import 'package:portfolio/view-models/programs_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/projects/widgets/project_item.dart';
import 'package:portfolio/widgets/app_spacing.dart';
import 'package:portfolio/widgets/header_title.dart';
import 'package:portfolio/widgets/text/index.dart';

class ProjectsView extends StatelessWidget {
   ProjectsView({super.key});
    final programController = Get.put(ProgramController());
    final localeController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      programController.loadData(localeController.currentLanguageEnums.value);
    });

    return Obx(() {
            if (programController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final data = programController.data.value;
            if (data == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, data);
          });
  }

  Widget  body(BuildContext context, List<ProgramModel> dataList)
  {
    return Row(
      children: [
        Expanded(
          child: Padding(
          padding:  ConsPadding.onlyRightHalf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(title: LocaleKeys.general_projects.tr()),
                Visibility(
                  visible: !context.isMobile,
                  child: TextTitleMedium(text: LocaleKeys.project_imageDescription.tr(), opacity:.7 ,)
                   ),
                  Visibility(
                  visible: !context.isMobile,            
                    child: AppSpacing.lowHeight),
                generateList( dataList)
              ],
            ),
          ),
        ),
        Visibility(
          visible: !(context.isMobile || context.isTabletV),
          child: AppSpacing().phoneLayer(context),
        )
      ],
    );
  }

  Widget generateList( List<ProgramModel> dataList)=> Column(children: List.generate(dataList.length, (index)=> ProjectsItem(data: dataList[index])),);


}


