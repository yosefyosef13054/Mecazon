class RequestGetArticleModel {
  GetArticles? getArticles;

  RequestGetArticleModel({this.getArticles});

  RequestGetArticleModel.fromJson(Map<String, dynamic> json) {
    getArticles = json['getArticles'] != null
        ? GetArticles.fromJson(json['getArticles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getArticles != null) {
      data['getArticles'] = getArticles!.toJson();
    }
    return data;
  }
}

class GetArticles {
  String? articleCountry;
  int? provider;
  String? searchQuery;
  int? searchType;
  String? lang;
  int? perPage;
  int? page;
  int? assemblyGroupNodeIds;
  bool? includeImages;

  GetArticles(
      {this.articleCountry,
        this.provider,
        this.searchQuery,
        this.searchType,
        this.lang,
        this.perPage,
        this.page,
        this.assemblyGroupNodeIds,
        this.includeImages
      });

  GetArticles.fromJson(Map<String, dynamic> json) {
    articleCountry = json['articleCountry'];
    provider = json['provider'];
    searchQuery = json['searchQuery'];
    searchType = json['searchType'];
    lang = json['lang'];
    perPage = json['perPage'];
    page = json['page'];
    assemblyGroupNodeIds = json['assemblyGroupNodeIds'];
    includeImages = json['includeImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleCountry'] = articleCountry;
    data['provider'] = provider;
    data['searchQuery'] = searchQuery;
    data['searchType'] = searchType;
    data['lang'] = lang;
    data['perPage'] = perPage;
    data['page'] = page;
    data['assemblyGroupNodeIds'] = assemblyGroupNodeIds;
    data['includeImages'] = includeImages;
    return data;
  }
}
