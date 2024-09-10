class GetCarData {
  int? total;
  List<CarData>? carList;
  int? status;

  GetCarData({this.total, this.carList, this.status});

  GetCarData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['linkageTargets'] != null) {
      carList = <CarData>[];
      json['linkageTargets'].forEach((v) {
        carList!.add(CarData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (carList != null) {
      data['linkageTargets'] =
          carList!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class CarData {
  int? linkageTargetId;
  String? linkageTargetType;
  String? subLinkageTargetType;
  String? description;
  int? mfrId;
  String? mfrName;
  String? mfrShortName;
  int? vehicleModelSeriesId;
  String? vehicleModelSeriesName;
  int? brakeTypeKey;
  String? brakeType;
  List<CarImage>? vehicleImages;

  CarData(
      {this.linkageTargetId,
        this.linkageTargetType,
        this.subLinkageTargetType,
        this.description,
        this.mfrId,
        this.mfrName,
        this.mfrShortName,
        this.vehicleModelSeriesId,
        this.vehicleModelSeriesName,
        this.brakeTypeKey,
        this.brakeType,
        this.vehicleImages});

  CarData.fromJson(Map<String, dynamic> json) {
    linkageTargetId = json['linkageTargetId'];
    linkageTargetType = json['linkageTargetType'];
    subLinkageTargetType = json['subLinkageTargetType'];
    description = json['description'];
    mfrId = json['mfrId'];
    mfrName = json['mfrName'];
    mfrShortName = json['mfrShortName'];
    vehicleModelSeriesId = json['vehicleModelSeriesId'];
    vehicleModelSeriesName = json['vehicleModelSeriesName'];
    brakeTypeKey = json['brakeTypeKey'];
    brakeType = json['brakeType'];
    if (json['vehicleImages'] != null) {
      vehicleImages = <CarImage>[];
      json['vehicleImages'].forEach((v) {
        vehicleImages!.add(CarImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linkageTargetId'] = linkageTargetId;
    data['linkageTargetType'] = linkageTargetType;
    data['subLinkageTargetType'] = subLinkageTargetType;
    data['description'] = description;
    data['mfrId'] = mfrId;
    data['mfrName'] = mfrName;
    data['mfrShortName'] = mfrShortName;
    data['vehicleModelSeriesId'] = vehicleModelSeriesId;
    data['vehicleModelSeriesName'] = vehicleModelSeriesName;
    data['brakeTypeKey'] = brakeTypeKey;
    data['brakeType'] = brakeType;
    if (vehicleImages != null) {
      data['vehicleImages'] =
          vehicleImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarImage {
  String? imageURL100;

  CarImage({this.imageURL100});

  CarImage.fromJson(Map<String, dynamic> json) {
    imageURL100 = json['imageURL100'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageURL100'] = imageURL100;
    return data;
  }
}
