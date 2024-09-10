import 'dart:convert';

import 'package:mecazone/helper/api.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Wishlist/wishlist_product_data_model.dart';
import 'package:mecazone/model/Wishlist/wishlist_store_data_model.dart';

class WishlistServiceController {
  static Future<WishListStoreDataModel?> getWishlistStore({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getWishlistStore RESPONSE : $response");
      WishListStoreDataModel? apiResponse = WishListStoreDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      // if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message!);
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<WishListProductDataModel?> getWishlistProduct({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getWishlistProduct RESPONSE : $response");
      WishListProductDataModel? apiResponse = WishListProductDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      // if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message!);
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> addStoreWishList(Map<String, String> params) async {
    return API.call(ADD_WISHLIST_STORE, MethodType.POST, body: params, formData: true).then((response) {
      Log.debug("addStoreWishList RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      return null;
    });
  }

  static Future<APIResponse?> addProductWishList(Map<String, String> params) async {
    return API.call(ADD_WISHLIST_PRODUCT, MethodType.POST,body: params, formData: true).then((response) {
      Log.debug("addProductWishList RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        // AlertHelper.showToast(apiResponse.message!);
        return apiResponse;
      }
      // if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message!);
      return null;
    }).catchError((onError) {
      return null;
    });
  }
}
