import 'package:get/get.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/model/User/profile_data_model.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/model/User/user_data_model.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/Login/login_screen.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}

class ProfileController extends GetxController{

  final rxIsShowLoader = false.obs;

  /// : CALL GET USER PROFILE DATA API
  callGetProfileDataAPI() async {
    try {
      rxIsShowLoader.value = true;
      Map<String, String> param = {'id': CommonWidget.user!.id.toString()};

      ProfileDataModel? apiResponse = await UserServiceController.getUserProfileDetails(param);
      rxIsShowLoader.value = false;

      if (apiResponse != null) {
        if (apiResponse.success!) {
          CommonWidget.user = apiResponse.result?.user;
          update();
        } else {

        }
      }
    } catch (e) {
      rxIsShowLoader.value = false;
    }
  }

  /// : CALL DISCONNECT DATA API
  callDisconnectAPI() async {
    try{
      rxIsShowLoader(true);
      Map<String, String> param = {
        'frontUserId': CommonWidget.user!.id.toString()
      };
      Log.debug("Request Param : $param");
      APIResponse? apiResponse = await UserServiceController.disconnectUser(param);
      rxIsShowLoader(false);
      if (apiResponse != null && apiResponse.success!) {
        User? user = User();
        SharedPref.savePreferenceValue(kUserModelKey, user);
        SharedPref.savePreferenceValue(isLogin, false);
        CommonWidget.user = null;
        Get.offAllNamed(LoginScreen.route);
      }
    }catch(e){
      Log.debug("Error : $e");
    }
  }

}