class CategoryModel {
  ResponseDescription? responseDescription;
  List<AppCategories>? appCategories;

  CategoryModel({this.responseDescription, this.appCategories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['appCategories'] != null) {
      appCategories = <AppCategories>[];
      json['appCategories'].forEach((v) {
        appCategories!.add(new AppCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.appCategories != null) {
      data['appCategories'] =
          this.appCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseDescription {
  int? errorCode;
  String? errorMessage;

  ResponseDescription({this.errorCode, this.errorMessage});

  ResponseDescription.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class AppCategories {
  int? id;
  String? categoryDisplayName;
  String? categoryName;
  String? language;
  int? portalId;
  String? status;
  int? displayIndex;
  String? pageName;
  bool? isDebug;

  AppCategories(
      {this.id,
      this.categoryDisplayName,
      this.categoryName,
      this.language,
      this.portalId,
      this.status,
      this.displayIndex,
      this.pageName,
      this.isDebug});

  AppCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryDisplayName = json['categoryDisplayName'];
    categoryName = json['categoryName'];
    language = json['language'];
    portalId = json['portalId'];
    status = json['status'];
    displayIndex = json['displayIndex'];
    pageName = json['pageName'];
    isDebug = json['isDebug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryDisplayName'] = this.categoryDisplayName;
    data['categoryName'] = this.categoryName;
    data['language'] = this.language;
    data['portalId'] = this.portalId;
    data['status'] = this.status;
    data['displayIndex'] = this.displayIndex;
    data['pageName'] = this.pageName;
    data['isDebug'] = this.isDebug;
    return data;
  }
}
