class RequestGetCarModelType {
  GetVehicleIdsByCriteria? getVehicleIdsByCriteria;

  RequestGetCarModelType({this.getVehicleIdsByCriteria});

  RequestGetCarModelType.fromJson(Map<String, dynamic> json) {
    getVehicleIdsByCriteria = json['getVehicleIdsByCriteria'] != null
        ? GetVehicleIdsByCriteria.fromJson(json['getVehicleIdsByCriteria'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getVehicleIdsByCriteria != null) {
      data['getVehicleIdsByCriteria'] = getVehicleIdsByCriteria!.toJson();
    }
    return data;
  }
}

class GetVehicleIdsByCriteria {
  String? carType;
  String? countriesCarSelection;
  String? lang;
  int? manuId;
  int? modId;
  int? favouredList;
  int? yearOfConstruction;
  int? provider;

  GetVehicleIdsByCriteria(
      {this.carType,
        this.countriesCarSelection,
        this.lang,
        this.manuId,
        this.modId,
        this.favouredList,
        this.yearOfConstruction,
        this.provider});

  GetVehicleIdsByCriteria.fromJson(Map<String, dynamic> json) {
    carType = json['carType'];
    countriesCarSelection = json['countriesCarSelection'];
    lang = json['lang'];
    manuId = json['manuId'];
    modId = json['modId'];
    favouredList = json['favouredList'];
    yearOfConstruction = json['yearOfConstruction'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carType'] = carType;
    data['countriesCarSelection'] = countriesCarSelection;
    data['lang'] = lang;
    data['manuId'] = manuId;
    data['modId'] = modId;
    data['favouredList'] = favouredList;
    data['yearOfConstruction'] = yearOfConstruction;
    data['provider'] = provider;
    return data;
  }
}
