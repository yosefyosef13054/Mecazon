class RequestGetCarDetailsModel {
  GetVehicleByIds4? getVehicleByIds4;

  RequestGetCarDetailsModel({this.getVehicleByIds4});

  RequestGetCarDetailsModel.fromJson(Map<String, dynamic> json) {
    getVehicleByIds4 = json['getVehicleByIds4'] != null
        ? GetVehicleByIds4.fromJson(json['getVehicleByIds4'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getVehicleByIds4 != null) {
      data['getVehicleByIds4'] = getVehicleByIds4!.toJson();
    }
    return data;
  }
}

class GetVehicleByIds4 {
  String? articleCountry;
  CarIds? carIds;
  String? countriesCarSelection;
  String? country;
  String? lang;
  int? provider;

  GetVehicleByIds4(
      {this.articleCountry,
        this.carIds,
        this.countriesCarSelection,
        this.country,
        this.lang,
        this.provider});

  GetVehicleByIds4.fromJson(Map<String, dynamic> json) {
    articleCountry = json['articleCountry'];
    carIds = json['carIds'] != null ? CarIds.fromJson(json['carIds']) : null;
    countriesCarSelection = json['countriesCarSelection'];
    country = json['country'];
    lang = json['lang'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleCountry'] = articleCountry;
    if (carIds != null) {
      data['carIds'] = carIds!.toJson();
    }
    data['countriesCarSelection'] = countriesCarSelection;
    data['country'] = country;
    data['lang'] = lang;
    data['provider'] = provider;
    return data;
  }
}

class CarIds {
  List<int>? array;

  CarIds({this.array});

  CarIds.fromJson(Map<String, dynamic> json) {
    array = json['array'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['array'] = array;
    return data;
  }
}
