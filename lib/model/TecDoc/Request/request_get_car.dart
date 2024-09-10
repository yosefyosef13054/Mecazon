class RequestGetCar {
  GetLinkageTargets? getLinkageTargets;

  RequestGetCar({this.getLinkageTargets});

  RequestGetCar.fromJson(Map<String, dynamic> json) {
    getLinkageTargets = json['getLinkageTargets'] != null
        ? GetLinkageTargets.fromJson(json['getLinkageTargets'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLinkageTargets != null) {
      data['getLinkageTargets'] = getLinkageTargets!.toJson();
    }
    return data;
  }
}

class GetLinkageTargets {
  int? provider;
  String? linkageTargetCountry;
  String? lang;
  String? query;
  String? vehicleModelSeriesName;

  GetLinkageTargets(
      {this.provider,
        this.linkageTargetCountry,
        this.lang,
        this.query,
        this.vehicleModelSeriesName});

  GetLinkageTargets.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    linkageTargetCountry = json['linkageTargetCountry'];
    lang = json['lang'];
    query = json['query'];
    vehicleModelSeriesName = json['vehicleModelSeriesName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provider'] = provider;
    data['linkageTargetCountry'] = linkageTargetCountry;
    data['lang'] = lang;
    data['query'] = query;
    data['vehicleModelSeriesName'] = vehicleModelSeriesName;
    return data;
  }
}
