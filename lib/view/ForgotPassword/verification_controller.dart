import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/User/forgot_password_data_model.dart';
import 'package:mecazone/model/User/top_verification_data_model.dart';
import 'package:mecazone/model/User/verification_data_model.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/Home/home_screen.dart';
import 'package:mecazone/view/Register/approval_screen.dart';
import 'package:mecazone/view/ForgotPassword/reset_password_screen.dart';

class VerificationBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(VerificationController());
  }
}

class VerificationController extends GetxController{

  late final int? userId;
  late final String? otpSentByText,email, mobileNo, countryCode;
  late final bool isFromForgotPwd,isFromRegister;

  dynamic argsData = Get.arguments;

  late TextEditingController pinController;
  var pinPutFocusNode = FocusNode();

  final rxResendSeconds = 60.obs;
  final rxIsShowLoader = false.obs;

  late Timer timer;
  late PinTheme defaultPinTheme ;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {
      pinPutFocusNode.dispose();
  }

  _init(){
    email = argsData['email'] ?? "";
    mobileNo = argsData['mobileNo'] ?? "";
    countryCode = argsData['countryCode'] ?? "";
    otpSentByText = argsData['otpSentByText'] ?? "";
    userId = argsData['userId']?? 0;
    isFromForgotPwd = argsData['isFromForgotPwd'] ?? false;
    isFromRegister = argsData['isFromRegister'] ?? false;

    pinController = TextEditingController();
    defaultPinTheme = PinTheme(
      margin: const EdgeInsets.all(5),
      width: 50,
      height: 50,
      textStyle: Get.context!.theme.textTheme.headlineMedium,
      decoration: BoxDecoration(
        color: AppColor.appButtonGreyColor,
        border: Border.all(color: AppColor.appButtonGreyColor),
        borderRadius: BorderRadius.circular(5),
      ),
    );
    startTimer();
    update();
  }

  /// : START TIMER CALL
  void startTimer() {
    rxResendSeconds.value = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (rxResendSeconds.value != 0) {
        rxResendSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  /// : SEND OTP ON EMAIL API CALL
  callSendOTPOnEmailAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    rxIsShowLoader.value = true;
    Map<String, String> params = {};

    if (isFromForgotPwd == true && email!.isNotEmpty) {
      params = {"stringValidate": email!};
      ForgotPasswordDataModel? apiResponse = await UserServiceController.forgotPasswordSendOTP(params);
      if (apiResponse != null) {
        AlertHelper.showToast(apiResponse.messages!);
      }
      if (apiResponse != null) {
        if (apiResponse.success! == true) {
          startTimer();
        }
      }
    } else {
      params = {
        "emailOrSms": "1", /// :  HERE 1 MEANS EMAIL THROUGH SEND OTP
        "registerOrForgot": "1", /// :  HERE 1 MEANS REGISTER TIME
        "userId": userId.toString(),
        "email": email!,
      };
      OTPVerificationDataModel? apiResponse = await UserServiceController.sendOTP(params);
      if (apiResponse != null) {
        AlertHelper.showToast(apiResponse.messages!);
      }
      if (apiResponse != null) {
        if (apiResponse.success! == true) {
          startTimer();
        }
      }
    }

    pinController.text = "";
    rxIsShowLoader.value = false;
    update();
  }

  /// : SEND OTP ON MOBILE API CALL
  callSendOTPOnMobileNo() async {
    try {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      rxIsShowLoader.value = true;
      await FirebaseAuth.instance
          .verifyPhoneNumber(
        // phoneNumber: "+${widget.countryCode} ${widget.mobileNo}",
        phoneNumber: "+${91} $mobileNo",
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
          startTimer();
        },
        forceResendingToken: 4,
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
    update();
  }

  /// : EMAIL - VERIFY OTP API CALL
  callVerifyOTPAPI({bool? isFromMobileNo = false}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    rxIsShowLoader.value = true;

    Map<String, String> params = {
      "RegisterOrForgot": isFromForgotPwd ? "0" : "1",
      "MobileNumber": mobileNo ?? "",
      "Email": email ?? "",
      "Otp": isFromMobileNo! ? "123456" : pinController.text,
      "Id": userId!.toString()
    };

    VerificationDataModel? apiResponse = await UserServiceController.verifyOTP(params);
    rxIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success! == true) {
        if (isFromForgotPwd == true) {
          Get.toNamed(ResetPasswordScreen.route,arguments: {
            'userId': userId,
          });
        } else {
          SharedPref.savePreferenceValue(kUserModelKey, apiResponse.result!.user!);
          SharedPref.savePreferenceValue(isLogin, true);
          CommonWidget.user = apiResponse.result!.user;

          if (apiResponse.result!.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL && apiResponse.result!.user!.isAdminApprove != true) {
            NavigatorHelper.removeAllAndOpen(const ApprovalScreen());
          } else {
            SharedPref.savePreferenceValue(kUserModelKey, apiResponse.result!.user!);
            SharedPref.savePreferenceValue(isLogin, true);
            CommonWidget.user = apiResponse.result!.user;
            Get.offAndToNamed(
              HomeScreen.route ,
              arguments: {
                'userId': apiResponse.result!.user!.id,
              }
            );
          }
        }
      } else {
        pinController.text = "";
      }
    }
    update();
  }

  /// : MOBILE NO USING FIREBASE - VERIFY OTP API CALL
  callVerifyOTPOnMobileAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    rxIsShowLoader.value = true;

    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: pinController.text))
          .then((value) async {
          if (value.user != null) {
            /// : BELOW API CALL - BECAUSE SERVER NOT IDENTIFIED WHICH MOBILE NO OTP IS VERIFIED - WHEN FIREBASE THROUGH OTP VERIFICATION
            callVerifyOTPAPI(isFromMobileNo: true);
          } else {
            rxIsShowLoader.value = false;
          }
        },
      );
    } catch (exception) {
      rxIsShowLoader.value = false;
      pinController.text = "";
      if (exception.toString().contains("invalid-phone-number")) {
        AlertHelper.showToast("invalidMobileValidation".translate());
      } else if (exception.toString().contains("session-expired")) {
        AlertHelper.showToast("smsCodeExpiredValidation".translate());
      } else {
        AlertHelper.showToast("invalidOTPCodeValidation".translate());
      }
      Log.debug("Failed, ${exception.toString()}");
    }
    update();
  }

}