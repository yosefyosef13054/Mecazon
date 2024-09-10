import 'package:get/get.dart';

class ProductDetailsBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductDetailsController());
  }
}

class ProductDetailsController extends GetxController{

}