import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/model/User/profile_data_model.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/utils/common_widget.dart';

class EditProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}

class EditProfileController extends GetxController{

  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController,
      lastNameController,
      emailController,
      mobileNoController,
      addressController;

  final nodes = [
    FocusNode(debugLabel: 'firstName'),
    FocusNode(debugLabel: 'fnLastName'),
    FocusNode(debugLabel: 'fnEmail'),
    FocusNode(debugLabel: 'fnMobileNo'),
    FocusNode(debugLabel: 'fnAddress')
  ];

  final rxIsProfileType = 1.obs;
  final rxIsShowLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {
    for (final node in nodes) {
      node.dispose();
    }
  }

  _init(){
    firstNameController = TextEditingController(text: CommonWidget.user?.firstName ?? "");
    lastNameController = TextEditingController(text: CommonWidget.user?.lastName ?? "");
    emailController = TextEditingController(text: CommonWidget.user?.email ?? "");
    mobileNoController = TextEditingController(text: CommonWidget.user?.phone ?? "");
    addressController = TextEditingController(text: CommonWidget.user?.address ?? "");
    update();
  }

  /// : EDIT PROFILE API CALL
  callEditProfileAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {

      Map<String, String> params = {
        "Id": CommonWidget.user!.id.toString(),
        "FirstName": firstNameController.text.trim().toString(),
        "LastName": lastNameController.text.trim().toString(),
        "Address": addressController.text.trim().toString()
      };

      rxIsShowLoader.value = true;
      ProfileDataModel? apiResponse = await UserServiceController.editProfileDetails(params);
      rxIsShowLoader.value = false;

      if (apiResponse != null) {
        if (apiResponse.success! == true) {
          CommonWidget.user = apiResponse.result!.user;
          update();
          Get.back(result: true);
        }
      }
    } else {}
  }

}