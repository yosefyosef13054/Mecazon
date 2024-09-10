class HomeDataModel {
  bool? success;
  String? messages;
  HomeResult? result;

  HomeDataModel({this.success, this.messages, this.result});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? HomeResult() : json['result'] != null ? HomeResult.fromJson(json['result']) : null;
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

class HomeResult {
  List<HomeBrandList>? homeBrandList;
  List<HomeCategoryList>? homeCategoryList;
  List<HomeBannerList>? homeBannerList;
  List<HomeCarList>? homeCarList;
  int? noOfCars;

  HomeResult(
      {this.homeBrandList,
        this.homeCategoryList,
        this.homeCarList,
        this.homeBannerList,
        this.noOfCars});

  HomeResult.fromJson(Map<String, dynamic> json) {
    noOfCars = json['noOfCars']??0;
    if (json['brandList'] != null) {
      homeBrandList = <HomeBrandList>[];
      json['brandList'].forEach((v) {
        homeBrandList!.add(HomeBrandList.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      homeCategoryList = <HomeCategoryList>[];
      json['categoryList'].forEach((v) {
        homeCategoryList!.add(HomeCategoryList.fromJson(v));
      });
    }
    if (json['bannerList'] != null) {
      homeBannerList = <HomeBannerList>[];
      json['bannerList'].forEach((v) {
        homeBannerList!.add(HomeBannerList.fromJson(v));
      });
    }
    if (json['userProductList'] != null) {
      homeCarList = <HomeCarList>[];
      json['userProductList'].forEach((v) {
        homeCarList!.add(HomeCarList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noOfCars'] = noOfCars;
    if (homeBrandList != null) {
      data['brandList'] = homeBrandList!.map((v) => v.toJson()).toList();
    }
    if (homeCategoryList != null) {
      data['categoryList'] = homeCategoryList!.map((v) => v.toJson()).toList();
    }
    if (homeBannerList != null) {
      data['bannerList'] = homeBannerList!.map((v) => v.toJson()).toList();
    }
    if (homeCarList != null) {
      data['userProductList'] = homeCarList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeBrandList {
  int? id;
  String? brandName;
  String? strProfilePicture;

  HomeBrandList({this.id, this.brandName, this.strProfilePicture});

  HomeBrandList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    brandName = json['brandName']??"";
    strProfilePicture = json['strProfilePicture']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandName'] = brandName;
    data['strProfilePicture'] = strProfilePicture;
    return data;
  }
}

class HomeCategoryList {
  int? id;
  int? shortCutId;
  String? shortCutName;
  String? strImage;

  HomeCategoryList({this.id, this.shortCutName, this.strImage,this.shortCutId});

  HomeCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    shortCutId = json['shortCutId']??0;
    shortCutName = json['shortCutName']??"";
    strImage = json['strImage']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shortCutId'] = shortCutId;
    data['shortCutName'] = shortCutName;
    data['strImage'] = strImage;
    return data;
  }
}

class HomeBannerList {
  int? id;
  String? name;
  String? strProfilePicture;

  HomeBannerList({this.id, this.name, this.strProfilePicture});

  HomeBannerList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
    strProfilePicture = json['strProfilePicture']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['strProfilePicture'] = strProfilePicture;
    return data;
  }
}

class HomeCarList {
  int? id;
  String? brandName;
  String? modelName;
  String? image;
  int? brandId,modelId,modelTypeId;

  HomeCarList({this.id, this.brandName, this.modelName, this.image,this.brandId,this.modelId,this.modelTypeId});

  HomeCarList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    brandId = json['brandId']??0;
    modelId = json['modelId']??0;
    modelTypeId = json['modelTypeId']??0;
    brandName = json['brandName']??"";
    modelName = json['modelName']??"";
    image = json['image']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['modelId'] = modelId;
    data['modelTypeId'] = modelTypeId;
    data['brandName'] = brandName;
    data['modelName'] = modelName;
    data['image'] = image;
    return data;
  }
}
