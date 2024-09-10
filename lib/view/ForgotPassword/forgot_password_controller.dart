import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/model/User/forgot_password_data_model.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/ForgotPassword/verification_screen.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}

class ForgotPasswordController extends GetxController{

  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController,mobileNoController,countrySearchController;

  final nodes = [
    FocusNode(debugLabel: 'fnEmail'),
    FocusNode(debugLabel: 'fnMobileNo'),
    FocusNode(debugLabel: 'fnSearchCountry')
  ];

  final rxIsShowLoader = false.obs;
  final rxIsLoginType = 1.obs;

  final lstCountry = <CountryData>[].obs;
  final selectedCountry = Rx<CountryData>(CountryData(
      countryName: "Algeria",
      countryId: 1,
      countryCode: "213",
      currencyPre: "DZ"));

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

  _init() {
    emailController = TextEditingController();
    mobileNoController = TextEditingController();
    countrySearchController = TextEditingController();
  }

  /// : FORGOT PASSWORD TIME SEND OTP API CALL
  callForgotPasswordSendOTPAPI({bool? isFromMobileNo}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {
      rxIsShowLoader.value = true;

      Map<String, String> params = {
        "stringValidate": isFromMobileNo == true
            ? mobileNoController.text.trim()
            : emailController.text.trim()
      };

      ForgotPasswordDataModel? apiResponse = await UserServiceController.forgotPasswordSendOTP(params);

      rxIsShowLoader.value = false;

      if (apiResponse != null) {
        if (apiResponse.success! == true) {
          if (isFromMobileNo == true) {
            callSendOTPOnMobileNo(userId: apiResponse.result!.user!.id);
          } else {
            AlertHelper.showToast(apiResponse.messages!);
            Get.toNamed(
                VerificationScreen.route,
                arguments: {
                  'otpSentByText': emailController.text,
                  'email': emailController.text,
                  'userId': apiResponse.result!.user!.id,
                  'isFromForgotPwd': true,
                }
            );
          }
        }
      }
    }
  }

  /// : SEND OTP USING FIREBASE
  callSendOTPOnMobileNo({int? userId}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      try {
        rxIsShowLoader.value = true;
        await FirebaseAuth.instance.verifyPhoneNumber(
          // phoneNumber: "+${selectedCountry!.countryCode} ${mobileNoController.text.trim()}",
          phoneNumber: "+91 ${mobileNoController.text.trim()}",
          timeout: const Duration(seconds: 5),
          verificationCompleted: (PhoneAuthCredential credential) {
            Log.debug("Verification Completed");
          },
          verificationFailed: (FirebaseAuthException exception) {
            if (exception.code == "too-many-requests") {
              AlertHelper.showToast("otpTooManyAttemptsValidation".translate());
            } else if (exception.code == "invalid-phone-number") {
              AlertHelper.showToast("invalidMobileValidation".translate());
            }
            Log.error("Firebase error : ${exception.toString()}");
            rxIsShowLoader.value = false;
          },
          codeSent: (String vId, int? resendToken) async {
            AlertHelper.showToast("otpCodeSentSuccessfully".translate());
            // verificationId = vId;
            Get.toNamed(
                VerificationScreen.route,
                arguments: {
                  'otpSentByText': mobileNoController.text,
                  'mobileNo': mobileNoController.text,
                  'email': "",
                  'userId': userId,
                  'countryCode': "+91",
                  'isFromForgotPwd': true,
                }
            );
          },
          forceResendingToken: 2,
          codeAutoRetrievalTimeout: (String verificationId) {
            rxIsShowLoader.value = false;
          },
        ).catchError((onError) {
          Log.debug(onError);
          rxIsShowLoader.value = false;
        });
      } catch (error) {
        Log.debug(error);
        rxIsShowLoader.value = false;
      }
    }
  }


}