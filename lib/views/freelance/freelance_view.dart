import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/core/constant/cons_padding.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/core/init/lang/codegen_loader.g.dart';
import 'package:portfolio/models/freelance_model.dart';
import 'package:portfolio/view-models/freelance_controller.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';
import 'package:portfolio/views/freelance/widgets/freelance_item.dart';
import 'package:portfolio/widgets/header_title.dart';

class FreelanceView extends StatelessWidget {
   FreelanceView({super.key});
    final programController = Get.put(FreelanceController());
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

  Widget  body(BuildContext context, List<FreelanceModel> dataList)
  {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding:  ConsPadding.onlyRightHalf(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderTitle(title: LocaleKeys.general_freelanceAndPersonal.tr()),
                  generateList( dataList)
                ],
              ),
          ),
        ),
        Visibility(
          visible: !(context.isMobile || context.isTabletV),
          child: SizedBox(
                width:  context.screenWidth *.2 < 400 ? 350 : context.screenWidth*.2,
          ),
        )
      ],
    );
  }

  Widget generateList( List<FreelanceModel> dataList)=> Column(children: List.generate(dataList.length, (index)=> FreelanceItem(data: dataList[index])),);


}
