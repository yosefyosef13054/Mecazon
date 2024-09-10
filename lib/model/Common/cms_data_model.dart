class ContentDetail {
  int? id;
  int? pageId;
  // Null? pageDetails;
  String? page;
  // Null? pageList;
  String? title;
  String? content;
  bool? isActive;
  String? active;
  // Null? moduleName;
  int? createdBy;
  int? updatedBy;
  // Null? iListCMS;
  bool? isAdminUser;
  bool? isCurrentAdminUser;

  ContentDetail(
      {this.id,
        this.pageId,
        // this.pageDetails,
        this.page,
        // this.pageList,
        this.title,
        this.content,
        this.isActive,
        this.active,
        // this.moduleName,
        this.createdBy,
        this.updatedBy,
        // this.iListCMS,
        this.isAdminUser,
        this.isCurrentAdminUser});

  ContentDetail.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    pageId = json['pageId']??0;
    // pageDetails = json['pageDetails'];
    page = json['page']??"";
    // pageList = json['pageList'];
    title = json['title']??"";
    content = json['content']??"";
    isActive = json['isActive']??false;
    active = json['active']??"";
    // moduleName = json['moduleName'];
    createdBy = json['createdBy']??0;
    updatedBy = json['updatedBy']??0;
    // iListCMS = json['iListCMS'];
    isAdminUser = json['isAdminUser']??false;
    isCurrentAdminUser = json['isCurrentAdminUser']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pageId'] = pageId;
    // data['pageDetails'] = this.pageDetails;
    data['page'] = page;
    // data['pageList'] = this.pageList;
    data['title'] = title;
    data['content'] = content;
    data['isActive'] = isActive;
    data['active'] = active;
    // data['moduleName'] = this.moduleName;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    // data['iListCMS'] = this.iListCMS;
    data['isAdminUser'] = isAdminUser;
    data['isCurrentAdminUser'] = isCurrentAdminUser;
    return data;
  }
}
