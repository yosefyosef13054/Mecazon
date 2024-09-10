import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/model/User/top_verification_data_model.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/ForgotPassword/verification_screen.dart';

class OTPVerificationBinding  extends Bindings{
  @override
  void dependencies() {
    Get.put(OTPVerificationController());
  }
}

class OTPVerificationController extends GetxController{
  late final String? email, mobileNo, countryCode;
  late final int? userId;

  dynamic argsData = Get.arguments;
  final rxIsEmailSelected = true.obs, rxIsShowLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init(){
    email = argsData['email'] ?? "";
    mobileNo = argsData['mobileNo'] ?? "";
    countryCode = argsData['countryCode'] ?? "";
    userId = argsData['userId']?? 0;
    update();
  }

  /// : SEND  OTP API CALL
  callSendOTPOnEmailAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    rxIsShowLoader.value = true;

    Map<String, String> params = {
      "emailOrSms": rxIsEmailSelected.value ? "1" : "0",
      "registerOrForgot": "1", /// :  HERE 1 MEANS REGISTER TIME
      "userId": userId.toString(),
      "email": rxIsEmailSelected.value ? email! : mobileNo!
    };

    OTPVerificationDataModel? apiResponse = await UserServiceController.sendOTP(params);
    rxIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success! == true) {

      Get.toNamed(
          VerificationScreen.route,
          arguments: {
            'otpSentByText':email,
            'mobileNo': "",
            'email': email,
            'userId': userId
          }
      );
    }
  }

  /// : SEND  OTP ON MOBILE NO USING FIREBASE
  callSendOTPOnMobileNo() async {
    try {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      rxIsShowLoader.value = true;
      await FirebaseAuth.instance
          .verifyPhoneNumber(
        phoneNumber: "+$countryCode$mobileNo",
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
          Log.debug("Firebase error : ${exception.toString()}");
          rxIsShowLoader.value = false;
        },
        codeSent: (String vId, int? resendToken) async {
          AlertHelper.showToast("otpCodeSentSuccessfully".translate());
          // verificationId = vId;
          Get.toNamed(
              VerificationScreen.route,
              arguments: {
                'otpSentByText':mobileNo,
                'mobileNo': mobileNo,
                'email': "",
                'countryCode': countryCode,
                'userId': userId
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