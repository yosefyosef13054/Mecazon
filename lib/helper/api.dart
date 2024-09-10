// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/token/token_generate.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/controller/connection_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';

class API {
  static Map<String, String> getHeader({bool isImage = false}) => isImage
      ? {
          'Content-type': 'multipart/form-data',
          'Accept': 'multipart/form-data',
          'Accept-Language': acceptLangCode,
          'Authorization': bearerToken
        }
      : {
          'accept': '*/*',
          'Accept-Language': acceptLangCode,
          'Authorization': bearerToken
        };

  static Map<String,String> getTecDocHeader({String? contentLength}) => {
    'Accept': 'application/json',
    'ContentType': 'application/json',
    'Content-Type': 'application/xml',
    'x-api-key': '2BeBXg6Kohvp8fT6NLgBpDRWA4rgE4WBcYegvs3RgvoMt2ySyN2T',
    'ContentLength': contentLength ?? "0"
  };

  static Future<String> callMultipartFormData(
    String url,
    MethodType method, {
    required Map<String, String> body,
    bool isGet = false,
    bool? formData,
  }) async {
    Map<String, String> requestHeaders = getHeader(isImage: false);
    var controller = Get.find<ConnectionService>();
    if (!controller.isConnected.value) return "";
    var request = http.MultipartRequest(isGet ? 'GET' : 'POST', Uri.parse(url));

    request.headers.addAll(requestHeaders);
    request.fields.addAll(body);
    var response = await request.send();
    //*In case an error this will not be executed
    switch (response.statusCode) {
      case 200:
        String responseString = await response.stream.bytesToString();
        Log.debug("===========");
        Log.debug(responseString);
        return responseString;
      case 400:
        AlertHelper.showToast("${response.statusCode} Bad request!");
        break;
      case 401:
        String email = await SharedPref.readPreferenceValue(
            kPrefKeyEmail, PrefEnum.STRING);
        String mobileNo = await SharedPref.readPreferenceValue(
            kPrefKeyMobileNo, PrefEnum.STRING);
        String password = await SharedPref.readPreferenceValue(
            kPrefKeyPassword, PrefEnum.STRING);
        Map<String, dynamic> param = {
          'email': email,
          'mobileNumber': mobileNo,
          'password': password
        };
        var response = await http.post(Uri.parse(TOKEN),
            headers: {"Content-Type": "application/json", 'Accept': '*/*'},
            body: json.encode(param));
        Log.debug("===============");
        Log.debug(response.body.toString());
        Log.debug("===============");
        TokenGenerate? tokenGenerate =
            TokenGenerate.fromJson(jsonDecode(response.body));
        if (tokenGenerate.success!) {
          bearerToken = "bearer ${tokenGenerate.result!.token!}";
        } else {
          UserServiceController.appLogout();
          break;
        }
        return await callMultipartFormData(
          url,
          method,
          body: body,
        );
      default:
        AlertHelper.showToast(
            "${_httpResponseMessage(response.statusCode)} Forbidden!");
    }

    return "";
  }

  static Future<String> callPostMultipleImageWithArray(String url,
      {Map<String, String>? body, Map<String, List<File>>? fileBody}) async {
    //*Don't put it's already there we use Get.find<>();
    var controller = Get.find<ConnectionService>();
    if (!controller.isConnected.value) return "";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> requestHeaders = getHeader(isImage: true);

    request.headers.addAll(requestHeaders);
    request.fields.addAll(body!);
    if (fileBody!.isNotEmpty) {
      fileBody.forEach((fileKey, file) async {
        Log.debug("file key = ${fileKey.toString()}");
        Log.debug("file name = ${file.toString()}");
        for (final element in file) {
          var stream = http.ByteStream(Stream.castFrom(element.openRead()));
          var length = await element.length();
          var multipartFile = http.MultipartFile(fileKey, stream, length,
              filename: element.path.split('/').last);
          request.files.add(multipartFile);
        }
      });
    }

    return request.send().then((response) async {
      final int statusCode = response.statusCode;
      Log.debug("statusCode:==== $statusCode");

      return response.stream.bytesToString().then((responseString) {
        return responseString;
      });
    }).whenComplete(() => {});
  }

  static Future<String> call(
    String url,
    MethodType method, {
    Map<String, dynamic>? body,
    bool formData = false,
  }) async {
    Map<String, String> requestHeaders = getHeader();
    final link = Uri.parse(url);
    //*YOU DON'T put the controller Again it's already in the App
    //*Please check Main.dart line 75
    var controller = Get.find<ConnectionService>();
    if (controller.isConnected.isFalse) {
      Log.debug(
          "makeCall ~ No internet connection!:: show your common no internet view");
      return "";
    }

    String responseJson = '';
    try {
      http.Response response;
      switch (method) {
        case MethodType.GET:
          response = await http.get(link, headers: requestHeaders);
          break;
        case MethodType.POST:
          response = await http.post(link,
              headers: requestHeaders,
              body: body != null
                  ? formData
                      ? body
                      : json.encode(body)
                  : json.encode({}));
          break;
        case MethodType.PUT:
          response = await http.put(link,
              headers: requestHeaders,
              body: body != null ? json.encode(body) : json.encode({}));
          break;
        case MethodType.DELETE:
          response = await http.delete(link, headers: requestHeaders);
          break;
      }
      _printRequestInfo(response);
      //*In case of an error this will never execute
      switch (response.statusCode) {
        case 200:
          return response.body;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
          String email = await SharedPref.readPreferenceValue(
              kPrefKeyEmail, PrefEnum.STRING);
          String mobileNo = await SharedPref.readPreferenceValue(
              kPrefKeyMobileNo, PrefEnum.STRING);
          String password = await SharedPref.readPreferenceValue(
              kPrefKeyPassword, PrefEnum.STRING);
          var response = await http.post(Uri.parse(TOKEN),
              headers: {"Content-Type": "application/json", 'Accept': '*/*'},
              body: json.encode({
                'email': email,
                'mobileNumber': mobileNo,
                'password': password
              }));
          Log.debug("===============");
          Log.debug(response.body.toString());
          Log.debug("===============");
          TokenGenerate? tokenGenerate =
              TokenGenerate.fromJson(jsonDecode(response.body));
          if (tokenGenerate.success!) {
            bearerToken = "bearer ${tokenGenerate.result!.token!}";
          } else {
            UserServiceController.appLogout();
            break;
          }
          responseJson = await call(
            url,
            method,
            body: body,
          );
          break;
      }
      //Log.debug("makeCall ~ apiResponse :: " + responseJson.toString());
    } on Exception catch (e) {
      Log.debug("makeCall ~ Exception :: $e");
    }
    return responseJson;
  }

  static Future<String> callApi(String url, MethodType method,
      {Map<String, dynamic>? body, bool? showLoading, bool? formData}) async {
    Map<String, String> requestHeaders = getHeader();
    bool isFormData = formData ?? false;
    var controller = Get.find<ConnectionService>();
    if (controller.isConnected.value) {
      String responseJson = '';
      try {
        http.Response response;
        switch (method) {
          case MethodType.GET:
            response = await http.get(Uri.parse(url), headers: requestHeaders);
            break;
          case MethodType.POST:
            response = await http.post(Uri.parse(url),
                headers: requestHeaders,
                body: body != null
                    ? isFormData
                        ? body
                        : json.encode(body)
                    : json.encode({}));
            break;
          case MethodType.PUT:
            response = await http.put(Uri.parse(url),
                headers: requestHeaders,
                body: body != null ? json.encode(body) : json.encode({}));
            break;
          case MethodType.DELETE:
            response =
                await http.delete(Uri.parse(url), headers: requestHeaders);
            break;
        }
        _printRequestInfo(response);
        //*Unreachable bloc
        switch (response.statusCode) {
          case 200:
            return utf8.decode(response.bodyBytes).toString();
          case 401:
            responseJson = await callApi(
              url,
              method,
              body: body,
            );
            break;
          case 403:
          case 404:
          case 405:
          case 406:
          case 409:
          case 500:
          case 502:
          case 400:
            break;
          default:
            return responseJson;
        }
      } on Exception {
        Log.debug("Exception");
      }
      return responseJson;
    }
    return "";
  }

  static Future<String> callTecDocApi(MethodType method, {required String body}) async {

    Map<String, String> requestHeaders = getTecDocHeader(contentLength: "100");

    var controller = Get.find<ConnectionService>();
    if(!controller.isConnected.value){
      AlertHelper.showToast("".translate());
      return '';
    }

    var request = http.Request('POST', Uri.parse(TECDOC_BASE_URL));
    request.headers.addAll(requestHeaders);
    request.body = body;

    var response = await request.send();

    switch (response.statusCode) {
      case 200:
        String responseString = await response.stream.bytesToString();
        Log.debug("===========");
        Log.debug(responseString);
        return responseString;
      case 400:
        AlertHelper.showToast("${response.statusCode} Bad request!");
        break;
      case 401:
        AlertHelper.showToast("${response.statusCode} Unauthorized!");
        break;
      default:
        AlertHelper.showToast("${_httpResponseMessage(response.statusCode)} Forbidden!");
    }
    return "";

  }

  static String _httpResponseMessage(int statusCode) {
    switch (statusCode) {
      case 403:
        return 'Forbidden!';
      case 404:
        return 'Not found!';
      case 405:
        return 'Method not allowed!';
      case 406:
        return 'Not accepted!';
      case 409:
        return 'Conflict!';
      case 500:
        return 'Internal server error!';
      case 502:
        return 'Bad gateway!';
      default:
        return 'Something went wrong!';
    }
  }

  static void _printRequestInfo(http.Response response) {
    if (response.request != null) {
      final request = response.request!;
      Log.info("RESPONSE BODY :: ${response.body}");
      Log.debug("request url :==== ${request.url}");
      Log.debug("request body :==== ${response.body}");
      Log.debug("request header :==== ${request.headers}");
      Log.debug("statusCode:==== ${response.statusCode}");
      Log.debug("response:==== ${response.body}");
    }
  }
}

enum MethodType { GET, POST, PUT, DELETE }

class ApiV2 {
  static final _client = GetConnect()
    ..baseUrl = ''
    ..timeout = const Duration(seconds: 100);
  static Future<String?> post(String path, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final response = await _client.post(path, body, headers: headers);
      return response.isOk ? response.bodyString : null;
    } catch (e) {
      Log.error(e);
      return null;
    }
  }
}
