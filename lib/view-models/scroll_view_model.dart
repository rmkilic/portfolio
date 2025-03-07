/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollViewModel extends GetxController {
  // ScrollController'ı buraya alıyoruz
  final ScrollController scrollController = ScrollController();
  // Sayfa bölümleri için GlobalKey'ler
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey referencesKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey programsKey = GlobalKey();
  // Kaydırma işlemi yapacak fonksiyon
  void scrollToSection(GlobalKey sectionKey) {
    final RenderBox renderBox = sectionKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final offset = position.dy;
    scrollController.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/view-models/programs_controller.dart';

class ScrollViewModel extends GetxController {
  final ScrollController scrollController = ScrollController();

  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey referencesKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey programsKey = GlobalKey();
  final GlobalKey freelanceKey = GlobalKey();


  var activeSectionKey = Rx<GlobalKey?>(null); // Aktif section key

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_updateActiveSection);
  }

  void scrollToSection(GlobalKey sectionKey) {
    final RenderBox renderBox = sectionKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: null);
    final offset = position.dy + scrollController.offset -100;

    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
    final programController = Get.put(ProgramController());

  void _updateActiveSection() {
      

    final sections = {
      aboutKey: _getSectionOffset(aboutKey),
      experienceKey: _getSectionOffset(experienceKey),
      referencesKey: _getSectionOffset(referencesKey),
      resumeKey: _getSectionOffset(resumeKey),
      programsKey: _getSectionOffset(programsKey),
      freelanceKey: _getSectionOffset(freelanceKey)
    };

    for (var entry in sections.entries) {
      final key = entry.key;
      final offset = entry.value -100;

      if (scrollController.offset  >= offset &&
          scrollController.offset < offset +_getSectionHeight(key)) {
        activeSectionKey.value = key;
        if(key != programsKey)
        {
          programController.selectedProgram.value = null;
        }
        break;
      }
    }
  }

  double _getSectionOffset(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero, ancestor: null);
      return position.dy + scrollController.offset;
    }
    return double.infinity;
  }

  double _getSectionHeight(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0;
  }

  @override
  void onClose() {
    scrollController.removeListener(_updateActiveSection);
    scrollController.dispose();
    super.onClose();
  }
}
