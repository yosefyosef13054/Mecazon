class RequestGetBrandModel {
  GetManufacturers2? getManufacturers2;

  RequestGetBrandModel({this.getManufacturers2});

  RequestGetBrandModel.fromJson(Map<String, dynamic> json) {
    getManufacturers2 = json['getManufacturers2'] != null
        ? GetManufacturers2.fromJson(json['getManufacturers2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getManufacturers2 != null) {
      data['getManufacturers2'] = getManufacturers2!.toJson();
    }
    return data;
  }
}

class GetManufacturers2 {
  String? country;
  String? lang;
  String? linkingTargetType;
  int? provider;
  int? favouredList; /// : 1 = MEANS TOP FAVOURITE  AND 0 = MEANS COMMON

  GetManufacturers2(
      {this.country, this.lang, this.linkingTargetType, this.provider,this.favouredList});

  GetManufacturers2.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    lang = json['lang'];
    linkingTargetType = json['linkingTargetType'];
    provider = json['provider'];
    favouredList = json['favouredList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['lang'] = lang;
    data['linkingTargetType'] = linkingTargetType;
    data['provider'] = provider;
    data['favouredList'] = favouredList;
    return data;
  }
}
