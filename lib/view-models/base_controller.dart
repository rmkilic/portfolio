import 'package:get/get.dart';
import 'package:portfolio/enums/language_enums.dart';

abstract class BasePageController<T> extends GetxController {
  var isLoading = false.obs;
  var data = Rx<T?>(null);

  Future<T> fetchData(LanguageEnums language);

  void loadData(LanguageEnums language) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final result = await fetchData(language);
      data.value = result;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }
}
