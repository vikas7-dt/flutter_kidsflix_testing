class PreflightModel {
  ResponseDescription? responseDescription;
  List<MncMccConfigs>? mncMccConfigs;
  List<Languages>? languages;

  PreflightModel(
      {this.responseDescription, this.mncMccConfigs, this.languages});

  PreflightModel.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['mncMccConfigs'] != null) {
      mncMccConfigs = <MncMccConfigs>[];
      json['mncMccConfigs'].forEach((v) {
        mncMccConfigs!.add(new MncMccConfigs.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.mncMccConfigs != null) {
      data['mncMccConfigs'] =
          this.mncMccConfigs!.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
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

class MncMccConfigs {
  int? id;
  String? mncCode;
  String? mccCode;
  String? countryId;
  String? countryName;
  String? signupFlowType;
  String? status;
  String? telcoName;
  String? telcoNameAr;
  int? portalId;
  String? imageBaseUrl;
  List<ProductMeta>? productMeta;

  MncMccConfigs(
      {this.id,
        this.mncCode,
        this.mccCode,
        this.countryId,
        this.countryName,
        this.signupFlowType,
        this.status,
        this.telcoName,
        this.telcoNameAr,
        this.portalId,
        this.imageBaseUrl,
        this.productMeta});

  MncMccConfigs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mncCode = json['mncCode'];
    mccCode = json['mccCode'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    signupFlowType = json['signupFlowType'];
    status = json['status'];
    telcoName = json['telcoName'];
    telcoNameAr = json['telcoNameAr'];
    portalId = json['portalId'];
    imageBaseUrl = json['imageBaseUrl'];
    if (json['productMeta'] != null) {
      productMeta = <ProductMeta>[];
      json['productMeta'].forEach((v) {
        productMeta!.add(new ProductMeta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mncCode'] = this.mncCode;
    data['mccCode'] = this.mccCode;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['signupFlowType'] = this.signupFlowType;
    data['status'] = this.status;
    data['telcoName'] = this.telcoName;
    data['telcoNameAr'] = this.telcoNameAr;
    data['portalId'] = this.portalId;
    data['imageBaseUrl'] = this.imageBaseUrl;
    if (this.productMeta != null) {
      data['productMeta'] = this.productMeta!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductMeta {
  int? id;
  String? mccCode;
  String? mncCode;
  String? productId;
  String? productName;
  String? status;
  String? countryId;
  String? countryName;
  String? displayIndex;
  String? subscriptionFlowType;
  List<Null>? metadatas;
  String? pushNotification;

  ProductMeta(
      {this.id,
        this.mccCode,
        this.mncCode,
        this.productId,
        this.productName,
        this.status,
        this.countryId,
        this.countryName,
        this.displayIndex,
        this.subscriptionFlowType,
        this.metadatas,
        this.pushNotification});

  ProductMeta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mccCode = json['mccCode'];
    mncCode = json['mncCode'];
    productId = json['productId'];
    productName = json['productName'];
    status = json['status'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    displayIndex = json['displayIndex'];
    subscriptionFlowType = json['subscriptionFlowType'];

    pushNotification = json['pushNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mccCode'] = this.mccCode;
    data['mncCode'] = this.mncCode;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['status'] = this.status;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['displayIndex'] = this.displayIndex;
    data['subscriptionFlowType'] = this.subscriptionFlowType;

    data['pushNotification'] = this.pushNotification;
    return data;
  }
}

class Languages {
  int? id;
  String? countryId;
  String? language;
  bool? isDefault;

  Languages({this.id, this.countryId, this.language, this.isDefault});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['countryId'];
    language = json['language'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['countryId'] = this.countryId;
    data['language'] = this.language;
    data['isDefault'] = this.isDefault;
    return data;
  }
}