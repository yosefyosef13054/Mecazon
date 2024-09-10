import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxService {
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInternet();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        isConnected(true);
      } else if (result == ConnectivityResult.wifi) {
        isConnected(true);
      } else {
        isConnected(false);
      }
    });
  }


  _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected(true);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConnected(true);
    } else {
      isConnected(false);
    }
  }

}
