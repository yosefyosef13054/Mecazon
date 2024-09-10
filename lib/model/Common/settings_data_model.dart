class SettingsDataModel {
  bool? success;
  String? messages;
  SettingResult? result;

  SettingsDataModel({this.success, this.messages, this.result});

  SettingsDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? SettingResult() : json['result'] != null ? SettingResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['messages'] = messages;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class SettingResult {
  CommonSettings? commonSettings;

  SettingResult({this.commonSettings});

  SettingResult.fromJson(Map<String, dynamic> json) {
    commonSettings = json['commonSettings'] != null
        ? CommonSettings.fromJson(json['commonSettings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commonSettings != null) {
      data['commonSettings'] = commonSettings!.toJson();
    }
    return data;
  }
}

class CommonSettings {
  int? id;
  String? smtpServer;
  String? email;
  String? password;
  String? port;
  String? siteURL;
  String? faceBookUrl;
  String? linkedinUrl;
  String? instagramUrl;
  bool? isSSL;
  String? apikey;
  String? countryCode;
  String? languageCode;
  String? jsonServiceUrl;
  int? providerId;
  int? numberOfProduct;
  int? maximumRequest;

  CommonSettings(
      {this.id,
        this.smtpServer,
        this.email,
        this.password,
        this.port,
        this.siteURL,
        this.numberOfProduct,
        this.faceBookUrl,
        this.linkedinUrl,
        this.instagramUrl,
        this.isSSL,
        this.providerId,
        this.apikey,
        this.countryCode,
        this.languageCode,
        this.jsonServiceUrl,
        this.maximumRequest});

  CommonSettings.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    smtpServer = json['smtpServer']??"";
    email = json['email']??"";
    password = json['password']??"";
    port = json['port']??"";
    siteURL = json['siteURL']??"";
    faceBookUrl = json['faceBookUrl']??"";
    linkedinUrl = json['linkedinUrl']??"";
    instagramUrl = json['instagramUrl']??"";
    isSSL = json['isSSL']??"";
    apikey = json['apikey']??"";
    countryCode = json['countryCode']??"DZ";
    languageCode = json['languageCode']??"fr";
    jsonServiceUrl = json['jsonServiceUrl']??"";
    providerId = json['providerId']??0;
    numberOfProduct = json['numberOfProduct']??0;
    maximumRequest = json['maximumRequest']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['smtpServer'] = smtpServer;
    data['email'] = email;
    data['password'] = password;
    data['port'] = port;
    data['siteURL'] = siteURL;
    data['faceBookUrl'] = faceBookUrl;
    data['linkedinUrl'] = linkedinUrl;
    data['instagramUrl'] = instagramUrl;
    data['isSSL'] = isSSL;
    data['apikey'] = apikey;
    data['countryCode'] = countryCode;
    data['languageCode'] = languageCode;
    data['jsonServiceUrl'] = jsonServiceUrl;
    data['providerId'] = providerId;
    data['numberOfProduct'] = numberOfProduct;
    data['maximumRequest'] = maximumRequest;
    return data;
  }
}
