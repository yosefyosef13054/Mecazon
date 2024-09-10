import 'dart:convert';
import 'package:get/get.dart';
import 'package:mecazone/model/User/forgot_password_data_model.dart';
import 'package:mecazone/model/User/login_data_model.dart';
import 'package:mecazone/model/User/top_verification_data_model.dart';
import 'package:mecazone/model/User/reset_password_data_model.dart';
import 'package:mecazone/model/User/verification_data_model.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/User/profile_data_model.dart';
import 'package:mecazone/model/User/user_data_model.dart';
import 'package:mecazone/view/Login/login_screen.dart';

class UserServiceController {
  static Future<LoginDataModel?> login(Map<String, String> params) async {
    return API
        .callMultipartFormData(LOGIN, MethodType.POST, body: params)
        .then((response) {
      Log.debug("LOGIN RESPONSE : $response");
      LoginDataModel? apiResponse =LoginDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        SharedPref.savePreferenceValue(kUserModelKey, apiResponse.result!.user!);
        SharedPref.savePreferenceValue(isLogin, true);
        CommonWidget.user = apiResponse.result!.user;
        SharedPref.savePreferenceValue(kPrefKeyEmail, CommonWidget.user!.email ?? "");
        SharedPref.savePreferenceValue(kPrefKeyMobileNo, CommonWidget.user!.phone ?? "");
        return apiResponse;
      }

      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> register(Map<String, String> params) async {
    return API.callMultipartFormData(SIGNUP, MethodType.POST, body: params).then((response) {
      Log.debug("REGISTER RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        if (apiResponse.message != "") {
          AlertHelper.showToast(apiResponse.message!);
        }
        return apiResponse;
      }
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<OTPVerificationDataModel?> sendOTP(
      Map<String, String> params) async {
    return API
        .call(SEND_OTP, MethodType.POST, body: params, formData: true)
        .then((response) {
      Log.debug("SENDOTP RESPONSE : $response");
      OTPVerificationDataModel? apiResponse =
          OTPVerificationDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<ForgotPasswordDataModel?> forgotPasswordSendOTP(
      Map<String, String> params) async {
    return API
        .call(FORGOT_PASSWORD, MethodType.POST, body: params, formData: true)
        .then((response) {
      Log.debug("FORGOT PASSWORD SEND OTP RESPONSE : $response");
      ForgotPasswordDataModel? apiResponse =
          ForgotPasswordDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<VerificationDataModel?> verifyOTP(
      Map<String, String> params) async {
    return API
        .call(VERIFY, MethodType.POST, body: params, formData: true)
        .then((response) {
      Log.debug("VERIFY OTP RESPONSE : $response");
      VerificationDataModel? apiResponse =
          VerificationDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        if (apiResponse.messages != "") {
          AlertHelper.showToast(apiResponse.messages!);
        }
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  /// : RESET PWD / CREATE NEW PWD
  static Future<ResetPasswordDataModel?> resetPassword(
      Map<String, String> params) async {
    return API
        .call(CREATE_PASSWORD, MethodType.POST, body: params, formData: true)
        .then((response) {
      Log.debug("RESET PASSWORD RESPONSE : $response");
      ResetPasswordDataModel? apiResponse =
          ResetPasswordDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        if (apiResponse.messages != "") {
          AlertHelper.showToast(apiResponse.messages!);
        }
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<ProfileDataModel?> getUserProfileDetails(
      Map<String, String> params) async {
    return API
        .callMultipartFormData(PROFILE_DETAILS, MethodType.POST, body: params)
        .then((response) {
      Log.debug("userProfileDetails RESPONSE : $response");

      ProfileDataModel? apiResponse =
          ProfileDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        SharedPref.savePreferenceValue(
            kUserModelKey, apiResponse.result!.user!);
        SharedPref.savePreferenceValue(isLogin, true);
        CommonWidget.user = apiResponse.result!.user;
        SharedPref.savePreferenceValue(
            kPrefKeyEmail, CommonWidget.user!.email ?? "");
        SharedPref.savePreferenceValue(
            kPrefKeyMobileNo, CommonWidget.user!.phone ?? "");
        return apiResponse;
      }

      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<ProfileDataModel?> editProfileDetails(
      Map<String, String> params) async {
    return API.callMultipartFormData(UPDATE_PROFILE, MethodType.POST, body: params).then((response) {
      Log.debug("EDIT PROFILE RESPONSE : $response");
      ProfileDataModel? apiResponse =
          ProfileDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> disconnectUser(Map<String, String> params) async {
    return API.callMultipartFormData(DISCONNECT_USER, MethodType.POST,body: params).then((response) {
      Log.debug("disconnectUser RESPONSE : $response");

      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        AlertHelper.showToast(apiResponse.message ?? "");
        return apiResponse;
      }

      if (apiResponse.message != ""){
        AlertHelper.showToast(apiResponse.message ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  /// : LOGOUT OPTION
  static appLogout({bool? isFromLogout}) {
    User? user = User();
    SharedPref.savePreferenceValue(kUserModelKey, user);
    SharedPref.savePreferenceValue(isLogin, false);
    CommonWidget.user = null;
    if (isFromLogout == true) {
      Get.toNamed(LoginScreen.route);
    }
  }
}
