import 'package:get/get.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController());
  }
}

class LanguageController extends GetxController {

  final vnIsSelectedLang = 2.obs;
  final isFromMenu = false.obs;

  dynamic argsData = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init() {
    isFromMenu.value = argsData['isFromMenu'] ?? false;
  }

}