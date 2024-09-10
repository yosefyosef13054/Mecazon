class RequestGetCategoryModel {
  GetChildNodesAllLinkingTarget2? getChildNodesAllLinkingTarget2;

  RequestGetCategoryModel({this.getChildNodesAllLinkingTarget2});

  RequestGetCategoryModel.fromJson(Map<String, dynamic> json) {
    getChildNodesAllLinkingTarget2 =
    json['getChildNodesAllLinkingTarget2'] != null
        ? GetChildNodesAllLinkingTarget2.fromJson(
        json['getChildNodesAllLinkingTarget2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getChildNodesAllLinkingTarget2 != null) {
      data['getChildNodesAllLinkingTarget2'] = getChildNodesAllLinkingTarget2!.toJson();
    }
    return data;
  }
}

class GetChildNodesAllLinkingTarget2 {
  String? articleCountry;
  bool? childNodes; /// :  true = means sub category and false means only category
  String? lang;
  String? linkingTargetType;
  int? provider;

  GetChildNodesAllLinkingTarget2(
      {this.articleCountry,
        this.childNodes,
        this.lang,
        this.linkingTargetType,
        this.provider});

  GetChildNodesAllLinkingTarget2.fromJson(Map<String, dynamic> json) {
    articleCountry = json['articleCountry'];
    childNodes = json['childNodes'];
    lang = json['lang'];
    linkingTargetType = json['linkingTargetType'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleCountry'] = articleCountry;
    data['childNodes'] = childNodes;
    data['lang'] = lang;
    data['linkingTargetType'] = linkingTargetType;
    data['provider'] = provider;
    return data;
  }
}
