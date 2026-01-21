class ProductsResponse {
  ResponseDescription? responseDescription;
  List<ProductMetas>? productMetas;

  ProductsResponse({this.responseDescription, this.productMetas});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['productMetas'] != null) {
      productMetas = <ProductMetas>[];
      json['productMetas'].forEach((v) {
        productMetas!.add(new ProductMetas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.productMetas != null) {
      data['productMetas'] = this.productMetas!.map((v) => v.toJson()).toList();
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

class ProductMetas {
  int? id;
  String? mccCode;
  String? mncCode;
  String? productId;
  String? productName;
  String? status;
  String? countryId;
  String? countryName;
  String? productType;
  String? displayIndex;
  String? subscriptionFlowType;
  String? price;
  String? currency;
  String? validity;
  String? descriptionEn;
  String? descriptionAr;
  List<Metadatas>? metadatas;
  String? playStoreProductId;
  String? pushNotification;

  ProductMetas(
      {this.id,
        this.mccCode,
        this.mncCode,
        this.productId,
        this.productName,
        this.status,
        this.countryId,
        this.countryName,
        this.productType,
        this.displayIndex,
        this.subscriptionFlowType,
        this.price,
        this.currency,
        this.validity,
        this.descriptionEn,
        this.descriptionAr,
        this.metadatas,
        this.playStoreProductId,
        this.pushNotification});

  ProductMetas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mccCode = json['mccCode'];
    mncCode = json['mncCode'];
    productId = json['productId'];
    productName = json['productName'];
    status = json['status'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    productType = json['productType'];
    displayIndex = json['displayIndex'];
    subscriptionFlowType = json['subscriptionFlowType'];
    price = json['price'];
    currency = json['currency'];
    validity = json['validity'];
    descriptionEn = json['descriptionEn'];
    descriptionAr = json['descriptionAr'];
    if (json['metadatas'] != null) {
      metadatas = <Metadatas>[];
      json['metadatas'].forEach((v) {
        metadatas!.add(new Metadatas.fromJson(v));
      });
    }
    playStoreProductId = json['playStoreProductId'];
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
    data['productType'] = this.productType;
    data['displayIndex'] = this.displayIndex;
    data['subscriptionFlowType'] = this.subscriptionFlowType;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['validity'] = this.validity;
    data['descriptionEn'] = this.descriptionEn;
    data['descriptionAr'] = this.descriptionAr;
    if (this.metadatas != null) {
      data['metadatas'] = this.metadatas!.map((v) => v.toJson()).toList();
    }
    data['playStoreProductId'] = this.playStoreProductId;
    data['pushNotification'] = this.pushNotification;
    return data;
  }
}

class Metadatas {
  int? id;
  String? productId;
  String? tncEn;
  String? tncAr;
  String? subButtonEn;
  String? subButtonAr;
  String? exitButtonEn;
  String? exitButtonAr;
  String? pinConfirmButtonEn;
  String? pinConfirmButtonAr;
  String? label1En;
  String? label1Ar;
  String? label2En;
  String? label2Ar;

  Metadatas(
      {this.id,
        this.productId,
        this.tncEn,
        this.tncAr,
        this.subButtonEn,
        this.subButtonAr,
        this.exitButtonEn,
        this.exitButtonAr,
        this.pinConfirmButtonEn,
        this.pinConfirmButtonAr,
        this.label1En,
        this.label1Ar,
        this.label2En,
        this.label2Ar});

  Metadatas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    tncEn = json['tncEn'];
    tncAr = json['tncAr'];
    subButtonEn = json['subButtonEn'];
    subButtonAr = json['subButtonAr'];
    exitButtonEn = json['exitButtonEn'];
    exitButtonAr = json['exitButtonAr'];
    pinConfirmButtonEn = json['pinConfirmButtonEn'];
    pinConfirmButtonAr = json['pinConfirmButtonAr'];
    label1En = json['label1En'];
    label1Ar = json['label1Ar'];
    label2En = json['label2En'];
    label2Ar = json['label2Ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['tncEn'] = this.tncEn;
    data['tncAr'] = this.tncAr;
    data['subButtonEn'] = this.subButtonEn;
    data['subButtonAr'] = this.subButtonAr;
    data['exitButtonEn'] = this.exitButtonEn;
    data['exitButtonAr'] = this.exitButtonAr;
    data['pinConfirmButtonEn'] = this.pinConfirmButtonEn;
    data['pinConfirmButtonAr'] = this.pinConfirmButtonAr;
    data['label1En'] = this.label1En;
    data['label1Ar'] = this.label1Ar;
    data['label2En'] = this.label2En;
    data['label2Ar'] = this.label2Ar;
    return data;
  }
}
