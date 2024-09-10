class SubscriptionDataModel {
  bool? success;
  String? messages;
  SubscriptionResult? result;

  SubscriptionDataModel({this.success, this.messages, this.result});

  SubscriptionDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success']??false;
    messages = json['messages']??"";
    result = json['result'] == "" ? SubscriptionResult() : json['result'] != null ? SubscriptionResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['messages'] = messages;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class SubscriptionResult {
  List<SubscriptionList>? subscriptionList;
  int? mySubscriptionId;

  SubscriptionResult({this.subscriptionList, this.mySubscriptionId});

  SubscriptionResult.fromJson(Map<String, dynamic> json) {
    if (json['subscriptionList'] != null) {
      subscriptionList = <SubscriptionList>[];
      json['subscriptionList'].forEach((v) {
        subscriptionList!.add(SubscriptionList.fromJson(v));
      });
    }
    mySubscriptionId = json['mySubscriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subscriptionList != null) {
      data['subscriptionList'] =
          subscriptionList!.map((v) => v.toJson()).toList();
    }
    data['mySubscriptionId'] = mySubscriptionId;
    return data;
  }
}

class SubscriptionList {
  int? subscriptionId;
  String? subscriptionName;
  int? storageNb;
  bool? priorityStore;
  bool? postRequest;
  bool? certifiedStore;
  bool? website;
  String? colorCode;
  String? image;
  List<PlanDetails>? planDetails;

  SubscriptionList(
      {this.subscriptionId,
        this.subscriptionName,
        this.storageNb,
        this.priorityStore,
        this.postRequest,
        this.certifiedStore,
        this.website,
        this.colorCode,
        this.image,
        this.planDetails});

  SubscriptionList.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId']??0;
    subscriptionName = json['subscriptionName']??"";
    storageNb = json['storageNb']??0;
    priorityStore = json['priorityStore']??false;
    postRequest = json['postRequest']??false;
    certifiedStore = json['certifiedStore']??false;
    website = json['website']??false;
    colorCode = json['colorCode']??"";
    image = json['image']??"";
    if (json['planDetails'] != null) {
      planDetails = <PlanDetails>[];
      json['planDetails'].forEach((v) {
        planDetails!.add(PlanDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscriptionId'] = subscriptionId;
    data['subscriptionName'] = subscriptionName;
    data['storageNb'] = storageNb;
    data['priorityStore'] = priorityStore;
    data['postRequest'] = postRequest;
    data['certifiedStore'] = certifiedStore;
    data['website'] = website;
    data['colorCode'] = colorCode;
    data['image'] = image;
    if (planDetails != null) {
      data['planDetails'] = planDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanDetails {
  int? planId;
  String? name;
  String? price;

  PlanDetails({this.planId, this.name, this.price});

  PlanDetails.fromJson(Map<String, dynamic> json) {
    planId = json['planId']??0;
    name = json['name']??"";
    price = json['price']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['planId'] = planId;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
