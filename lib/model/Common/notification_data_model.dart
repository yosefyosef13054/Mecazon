class NotificationDataModel {
  bool? success;
  String? messages;
  NotificationResult? result;

  NotificationDataModel({this.success, this.messages, this.result});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success']?? false;
    messages = json['messages']??"";
    result = json['result'] == "" ? NotificationResult() : json['result'] != null ? NotificationResult.fromJson(json['result']) : null;
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

class NotificationResult {
  List<NotificationList>? notificationList;

  NotificationResult({this.notificationList});

  NotificationResult.fromJson(Map<String, dynamic> json) {
    if (json['notificationDetails'] != null) {
      notificationList = <NotificationList>[];
      json['notificationDetails'].forEach((v) {
        notificationList!.add(NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationList != null) {
      data['notificationDetails'] =
          notificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  int? id;
  int? customerId;
  String? title;
  String? description;
  bool? isRead;
  String? dateTime;

  NotificationList(
      {this.id,
        this.customerId,
        this.title,
        this.description,
        this.isRead,
        this.dateTime});

  NotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    customerId = json['customerId']??0;
    title = json['title']??"";
    description = json['description']??"";
    isRead = json['isRead']??false;
    dateTime = json['dateTime']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerId'] = customerId;
    data['title'] = title;
    data['description'] = description;
    data['isRead'] = isRead;
    data['dateTime'] = dateTime;
    return data;
  }
}