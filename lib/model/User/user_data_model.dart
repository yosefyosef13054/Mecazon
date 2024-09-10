class User {
  int? id;
  int? profileTypeId;
  int? countryId;
  bool? isActive;
  bool? isCertificate;
  bool? isAdminApprove;
  bool? isMobileNumberVerified;
  bool? hasAddedStore;

  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? phone;
  String? profileName;
  String? moduleName;
  String? active;
  String? pairId;
  String? password;
  String? store;
  String? profileFile;
  String? profilePicture;

  User({
    this.id,
        this.countryId,
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.phone,
        this.profileTypeId,
        this.profileName,
        this.isActive,
        this.moduleName,
        this.active,
        this.pairId,
        this.isAdminApprove,
        this.isMobileNumberVerified,
        this.hasAddedStore,
        this.password,
        this.isCertificate,
        this.store,
        this.profileFile,
        this.profilePicture
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    countryId = json['countryId']??0;
    firstName = json['firstName']??"";
    lastName = json['lastName']??"";
    email = json['email']??"";
    address = json['address']??"";
    phone = json['phone']??"";
    profileTypeId = json['profileTypeId']??0;
    profileName = json['profileName']??"";
    isActive = json['isActive']??false;
    moduleName = json['moduleName']??"";
    active = json['active']??"";
    pairId = json['pairId']??"";
    isAdminApprove = json['isAdminApprove']??false;
    isMobileNumberVerified = json['isMobileNumberVerified']??false;
    hasAddedStore = json['hasAddedStore']??false;
    password = json['password']??"";
    isCertificate = json['isCertificate']??false;
    store = json['store'];
    profileFile = json['profileFile']??"";
    profilePicture = json['profilePicture']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryId'] = countryId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['profileTypeId'] = profileTypeId;
    data['profileName'] = profileName;
    data['isActive'] = isActive;
    data['moduleName'] = moduleName;
    data['active'] = active;
    data['pairId'] = pairId;
    data['isAdminApprove'] = isAdminApprove;
    data['isMobileNumberVerified'] = isMobileNumberVerified;
    data['hasAddedStore'] = hasAddedStore;
    data['password'] = password;
    data['isCertificate'] = isCertificate;
    data['store'] = store;
    data['profileFile'] = profileFile;
    data['profilePicture'] = profilePicture;
    return data;
  }
}