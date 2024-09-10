import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/view/ForgotPassword/opt_verification_screen.dart';
import 'package:mecazone/view/ForgotPassword/verification_screen.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}

class RegisterController extends GetxController {
  final nodes = [
    FocusNode(debugLabel: 'firstName'),
    FocusNode(debugLabel: 'fnLastName'),
    FocusNode(debugLabel: 'fnEmail'),
    FocusNode(debugLabel: 'fnMobileNo'),
    FocusNode(debugLabel: 'fnPassword'),
    FocusNode(debugLabel: 'fnConfirmPassword'),
    FocusNode(debugLabel: 'fnSearchCountry'),
  ];

  late TextEditingController firstNameController,
      lastNameController,
      emailController,
      mobileNoController,
      passwordController,
      confirmPasswordController,
      countrySearchController;

  final formKey = GlobalKey<FormState>();

  final rxIsShowLoader = false.obs;
  final rxProfileType = USER_TYPE_1056_CUSTOMER.obs; // 1 = customer and 2 = professional

  final lstCountry = <CountryData>[].obs;
  final selectedCountry = Rx<CountryData>(CountryData(
      countryName: "Algeria",
      countryId: 1,
      countryCode: "213",
      currencyPre: "DZ"));

  String pairId = "";

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

  _init() async {
    //Same thing for this controllers !!!
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNoController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    countrySearchController = TextEditingController();
    pairId = await SharedPref.readPreferenceValue(kPrefKeyPairId, PrefEnum.STRING);
  }

  void signUp() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      rxIsShowLoader.value = true;

      Map<String, String> params = {
        "FirstName": firstNameController.text.trim().toString(),
        "LastName": lastNameController.text.trim().toString(),
        "Email": emailController.text.trim().toString(),
        "Phone": mobileNoController.text.trim().toString(),
        "Password": passwordController.text.trim().toString(),
        "ConfirmPassword": confirmPasswordController.text.trim().toString(),
        "ProfileType": rxProfileType.value == USER_TYPE_1056_CUSTOMER
            ? USER_TYPE_1056_CUSTOMER.toString()
            : USER_TYPE_1057_PROFESSIONAL.toString(),
        "CountryId": selectedCountry.value.countryId.toString(),
        "Otp": "",
        "PairId": pairId,
        "CreatedBy": "0",
      };

      final apiResponse = await UserServiceController.register(params);
      rxIsShowLoader.value = false;

      if (apiResponse != null && apiResponse.success == true) {
        if (emailController.text.isNotEmpty && mobileNoController.text.isNotEmpty) {

          Get.toNamed(OTPVerificationScreen.route,arguments: {
            "email": emailController.text,
            "mobileNo": mobileNoController.text,
            "userId": apiResponse.result!.user!.id,
            "countryCode": selectedCountry.value.countryCode.toString()
          });

        } else {

          Get.toNamed(VerificationScreen.route,arguments: {
            'otpSentByText': emailController.text.trim().isNotEmpty
                ? emailController.text
                : mobileNoController.text,
            'mobileNo': mobileNoController.text,
            'email': emailController.text,
            'userId': apiResponse.result!.user!.id,
            'countryCode': selectedCountry.value.countryCode,
            'isFromRegister': true,
          }
          );
        }
      }
      return;
    }
    /// :  show error message
  }
}
