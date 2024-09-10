class StoreContactPersonDataModel {
  int? id;
  int? storeId;
  int? countryId;
  String? phoneNumber;

  StoreContactPersonDataModel(
      {this.id, this.storeId, this.countryId, this.phoneNumber});

  StoreContactPersonDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    storeId = json['storeId']??0;
    countryId = json['countryId']??0;
    phoneNumber = json['phoneNumber']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['countryId'] = countryId;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
