import 'package:get/get.dart';

class ManufacturerData {
  int? id,mfrId;
  String? mfrName;
  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED

  ManufacturerData({this.id, this.mfrName,this.isSelected,this.mfrId});

  ManufacturerData.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    mfrId = json['mfrId']??0;
    mfrName = json['mfrName']??"";
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mfrId'] = mfrId;
    data['mfrName'] = mfrName;
    return data;
  }
}
