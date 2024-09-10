class GetCarDetailsModel {
  Data? data;
  int? status;

  GetCarDetailsModel({this.data, this.status});

  GetCarDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] == "" ? Data() : json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  List<CarList>? carList;

  Data({this.carList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      carList = <CarList>[];
      json['array'].forEach((v) {
        carList!.add(CarList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carList != null) {
      data['array'] = carList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarList {
  int? carId;
  VehicleDetails? vehicleDetails;
  String? vehicleDocId;

  CarList({this.carId, this.vehicleDetails, this.vehicleDocId});

  CarList.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    vehicleDetails = json['vehicleDetails'] != null
        ? VehicleDetails.fromJson(json['vehicleDetails'])
        : null;
    vehicleDocId = json['vehicleDocId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carId'] = carId;
    if (vehicleDetails != null) {
      data['vehicleDetails'] = vehicleDetails!.toJson();
    }
    data['vehicleDocId'] = vehicleDocId;
    return data;
  }
}

class VehicleDetails {
  String? brakeSystem;
  int? carId;
  int? ccmTech;
  String? constructionType;
  int? cylinder;
  int? cylinderCapacityCcm;
  int? cylinderCapacityLiter;
  String? fuelType;
  String? fuelTypeProcess;
  String? impulsionType;
  int? manuId;
  String? manuName;
  int? modId;
  String? modelName;
  String? motorType;
  int? powerHpFrom;
  int? powerHpTo;
  int? powerKwFrom;
  int? powerKwTo;
  String? typeName;
  int? typeNumber;
  int? valves;
  int? yearOfConstrFrom;
  int? yearOfConstrTo;
  int? rmiTypeId;

  VehicleDetails(
      {this.brakeSystem,
        this.carId,
        this.ccmTech,
        this.constructionType,
        this.cylinder,
        this.cylinderCapacityCcm,
        this.cylinderCapacityLiter,
        this.fuelType,
        this.fuelTypeProcess,
        this.impulsionType,
        this.manuId,
        this.manuName,
        this.modId,
        this.modelName,
        this.motorType,
        this.powerHpFrom,
        this.powerHpTo,
        this.powerKwFrom,
        this.powerKwTo,
        this.typeName,
        this.typeNumber,
        this.valves,
        this.yearOfConstrFrom,
        this.yearOfConstrTo,
        this.rmiTypeId});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    brakeSystem = json['brakeSystem'];
    carId = json['carId'];
    ccmTech = json['ccmTech'];
    constructionType = json['constructionType'];
    cylinder = json['cylinder'];
    cylinderCapacityCcm = json['cylinderCapacityCcm'];
    cylinderCapacityLiter = json['cylinderCapacityLiter'];
    fuelType = json['fuelType'];
    fuelTypeProcess = json['fuelTypeProcess'];
    impulsionType = json['impulsionType'];
    manuId = json['manuId'];
    manuName = json['manuName'];
    modId = json['modId'];
    modelName = json['modelName'];
    motorType = json['motorType'];
    powerHpFrom = json['powerHpFrom'];
    powerHpTo = json['powerHpTo'];
    powerKwFrom = json['powerKwFrom'];
    powerKwTo = json['powerKwTo'];
    typeName = json['typeName'];
    typeNumber = json['typeNumber'];
    valves = json['valves'];
    yearOfConstrFrom = json['yearOfConstrFrom'];
    yearOfConstrTo = json['yearOfConstrTo'];
    rmiTypeId = json['rmiTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brakeSystem'] = brakeSystem;
    data['carId'] = carId;
    data['ccmTech'] = ccmTech;
    data['constructionType'] = constructionType;
    data['cylinder'] = cylinder;
    data['cylinderCapacityCcm'] = cylinderCapacityCcm;
    data['cylinderCapacityLiter'] = cylinderCapacityLiter;
    data['fuelType'] = fuelType;
    data['fuelTypeProcess'] = fuelTypeProcess;
    data['impulsionType'] = impulsionType;
    data['manuId'] = manuId;
    data['manuName'] = manuName;
    data['modId'] = modId;
    data['modelName'] = modelName;
    data['motorType'] = motorType;
    data['powerHpFrom'] = powerHpFrom;
    data['powerHpTo'] = powerHpTo;
    data['powerKwFrom'] = powerKwFrom;
    data['powerKwTo'] = powerKwTo;
    data['typeName'] = typeName;
    data['typeNumber'] = typeNumber;
    data['valves'] = valves;
    data['yearOfConstrFrom'] = yearOfConstrFrom;
    data['yearOfConstrTo'] = yearOfConstrTo;
    data['rmiTypeId'] = rmiTypeId;
    return data;
  }
}
