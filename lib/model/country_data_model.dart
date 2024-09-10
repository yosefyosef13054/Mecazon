class CountryData {
  int? countryId;
  String? countryCode;
  String? countryName;
  String? currencyPre;

  CountryData({this.countryId, this.countryName, this.countryCode,this.currencyPre});

  CountryData.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId']??0;
    countryCode = json['countryCode']??"";
    countryName = json['countryName']??"";
    currencyPre = json['currencyPre']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryId'] = countryId;
    data['countryCode'] = countryCode;
    data['countryName'] = countryName;
    data['currencyPre'] = currencyPre;
    return data;
  }
}
