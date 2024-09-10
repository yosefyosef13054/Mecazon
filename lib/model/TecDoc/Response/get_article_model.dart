class GetArticleModel {
  int? totalMatchingArticles;
  int? maxAllowedPage;
  List<ArticlesList>? articleList;
  int? status;

  GetArticleModel(
      {this.totalMatchingArticles,
        this.maxAllowedPage,
        this.articleList,
        this.status});

  GetArticleModel.fromJson(Map<String, dynamic> json) {
    totalMatchingArticles = json['totalMatchingArticles'];
    maxAllowedPage = json['maxAllowedPage'];
    if (json['articles'] != null) {
      articleList = <ArticlesList>[];
      json['articles'].forEach((v) {
        articleList!.add(ArticlesList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMatchingArticles'] = totalMatchingArticles;
    data['maxAllowedPage'] = maxAllowedPage;
    if (articleList != null) {
      data['articles'] = articleList!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ArticlesList {
  int? dataSupplierId;
  String? articleNumber;
  int? mfrId;
  String? mfrName;
  List<ArticleImageData>? articleImagesList;
  List<OEMNumbersData>? oemNumbersList;

  ArticlesList(
      {this.dataSupplierId,
        this.articleNumber,
        this.mfrId,
        this.mfrName,
        this.oemNumbersList,
        this.articleImagesList
      });

  ArticlesList.fromJson(Map<String, dynamic> json) {
    dataSupplierId = json['dataSupplierId'];
    articleNumber = json['articleNumber'];
    mfrId = json['mfrId'];
    mfrName = json['mfrName'];
    if (json['images'] != null) {
      articleImagesList = <ArticleImageData>[];
      json['images'].forEach((v) {
        articleImagesList!.add(ArticleImageData.fromJson(v));
      });
    }

    if (json['searchQueryMatches'] != null) {
      oemNumbersList = <OEMNumbersData>[];
      json['searchQueryMatches'].forEach((v) {
        oemNumbersList!.add(OEMNumbersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataSupplierId'] = dataSupplierId;
    data['articleNumber'] = articleNumber;
    data['mfrId'] = mfrId;
    data['mfrName'] = mfrName;
    if (articleImagesList != null) {
      data['images'] = articleImagesList!.map((v) => v.toJson()).toList();
    }
    if (oemNumbersList != null) {
      data['searchQueryMatches'] = oemNumbersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OEMNumbersData {
  String? matchType;
  String? description;
  String? oemNumber;
  int? mfrId;
  String? mfrName;

  OEMNumbersData(
      {this.matchType, this.description, this.oemNumber, this.mfrId, this.mfrName});

  OEMNumbersData.fromJson(Map<String, dynamic> json) {
    matchType = json['matchType'];
    description = json['description'];
    oemNumber = json['match'];
    mfrId = json['mfrId'];
    mfrName = json['mfrName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['matchType'] = matchType;
    data['description'] = description;
    data['match'] = oemNumber;
    data['mfrId'] = mfrId;
    data['mfrName'] = mfrName;
    return data;
  }
}

class ArticleImageData {
  String? imageURL100,fileName;

  ArticleImageData(
      {
        this.imageURL100,
        this.fileName
      });

  ArticleImageData.fromJson(Map<String, dynamic> json) {
    imageURL100 = json['imageURL100']??"";
    fileName = json['fileName']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageURL100'] = imageURL100;
    data['fileName'] = fileName;
    return data;
  }
}
