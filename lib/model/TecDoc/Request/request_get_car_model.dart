class RequestGetCarModel {
  GetModelSeries2? getModelSeries2;

  RequestGetCarModel({this.getModelSeries2});

  RequestGetCarModel.fromJson(Map<String, dynamic> json) {
    getModelSeries2 = json['getModelSeries2'] != null
        ? GetModelSeries2.fromJson(json['getModelSeries2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getModelSeries2 != null) {
      data['getModelSeries2'] = getModelSeries2!.toJson();
    }
    return data;
  }
}

class GetModelSeries2 {
  String? country;
  String? lang;
  String? linkingTargetType;
  int? manuId;
  int? provider;
  int? favouredList;

  GetModelSeries2(
      {this.country,
        this.lang,
        this.linkingTargetType,
        this.manuId,
        this.favouredList,
        this.provider});

  GetModelSeries2.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    lang = json['lang'];
    linkingTargetType = json['linkingTargetType'];
    manuId = json['manuId'];
    favouredList = json['favouredList']??1;
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['lang'] = lang;
    data['linkingTargetType'] = linkingTargetType;
    data['manuId'] = manuId;
    data['favouredList'] = favouredList;
    data['provider'] = provider;
    return data;
  }
}
