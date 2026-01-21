class BannerResponse {
  ResponseDescription? responseDescription;
  List<PortalBanners>? portalBanners;
  String? layoutName;

  BannerResponse(
      {this.responseDescription, this.portalBanners, this.layoutName});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['portalBanners'] != null) {
      portalBanners = <PortalBanners>[];
      json['portalBanners'].forEach((v) {
        portalBanners!.add(new PortalBanners.fromJson(v));
      });
    }
    layoutName = json['layoutName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.portalBanners != null) {
      data['portalBanners'] =
          this.portalBanners!.map((v) => v.toJson()).toList();
    }
    data['layoutName'] = this.layoutName;
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

class PortalBanners {
  int? id;
  int? portalId;
  int? pageId;
  int? pubSubId;
  String? url;
  String? info;
  String? text;
  String? imagepage;
  String? contentId;
  String? fromdate;
  String? todate;
  String? pricepointid;
  String? usercomment;
  int? itemtype;
  String? tagurl;
  String? album;
  bool? isDebug;
  String? isActive;
  String? infoAr;
  String? infoBm;
  String? textAr;
  String? usercommentAr;
  String? addInfo1;
  String? addInfo1Ar;
  String? addInfo2;
  String? addInfo2Ar;
  String? usercommentBm;
  String? addInfo1Bm;
  String? addInfo2Bm;
  int? displayIndex;
  bool? isSearchClick;
  List<ContentImages>? contentImages;
  bool? isAddedToWatchList;
  String? infoDisplay;
  String? usercommentDisplay;
  int? languageId;
  String? webpreview;

  PortalBanners(
      {this.id,
      this.portalId,
      this.pageId,
      this.pubSubId,
      this.url,
      this.info,
      this.text,
      this.imagepage,
      this.contentId,
      this.fromdate,
      this.todate,
      this.pricepointid,
      this.usercomment,
      this.itemtype,
      this.tagurl,
      this.album,
      this.isDebug,
      this.isActive,
      this.infoAr,
      this.infoBm,
      this.textAr,
      this.usercommentAr,
      this.addInfo1,
      this.addInfo1Ar,
      this.addInfo2,
      this.addInfo2Ar,
      this.usercommentBm,
      this.addInfo1Bm,
      this.addInfo2Bm,
      this.displayIndex,
      this.isSearchClick,
      this.contentImages,
      this.isAddedToWatchList,
      this.infoDisplay,
      this.usercommentDisplay,
      this.languageId,
      this.webpreview});

  PortalBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    portalId = json['portalId'];
    pageId = json['pageId'];
    pubSubId = json['pubSubId'];
    url = json['url'];
    info = json['info'];
    text = json['text'];
    imagepage = json['imagepage'];
    contentId = json['contentId'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    pricepointid = json['pricepointid'];
    usercomment = json['usercomment'];
    itemtype = json['itemtype'];
    tagurl = json['tagurl'];
    album = json['album'];
    isDebug = json['isDebug'];
    isActive = json['isActive'];
    infoAr = json['infoAr'];
    infoBm = json['infoBm'];
    textAr = json['textAr'];
    usercommentAr = json['usercommentAr'];
    addInfo1 = json['addInfo1'];
    addInfo1Ar = json['addInfo1Ar'];
    addInfo2 = json['addInfo2'];
    addInfo2Ar = json['addInfo2Ar'];
    usercommentBm = json['usercommentBm'];
    addInfo1Bm = json['addInfo1Bm'];
    addInfo2Bm = json['addInfo2Bm'];
    displayIndex = json['displayIndex'];
    isSearchClick = json['isSearchClick'];
    if (json['contentImages'] != null) {
      contentImages = <ContentImages>[];
      json['contentImages'].forEach((v) {
        contentImages!.add(new ContentImages.fromJson(v));
      });
    }
    isAddedToWatchList = json['isAddedToWatchList'];
    infoDisplay = json['infoDisplay'];
    usercommentDisplay = json['usercommentDisplay'];
    languageId = json['languageId'];
    webpreview = json['webpreview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['portalId'] = this.portalId;
    data['pageId'] = this.pageId;
    data['pubSubId'] = this.pubSubId;
    data['url'] = this.url;
    data['info'] = this.info;
    data['text'] = this.text;
    data['imagepage'] = this.imagepage;
    data['contentId'] = this.contentId;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['pricepointid'] = this.pricepointid;
    data['usercomment'] = this.usercomment;
    data['itemtype'] = this.itemtype;
    data['tagurl'] = this.tagurl;
    data['album'] = this.album;
    data['isDebug'] = this.isDebug;
    data['isActive'] = this.isActive;
    data['infoAr'] = this.infoAr;
    data['infoBm'] = this.infoBm;
    data['textAr'] = this.textAr;
    data['usercommentAr'] = this.usercommentAr;
    data['addInfo1'] = this.addInfo1;
    data['addInfo1Ar'] = this.addInfo1Ar;
    data['addInfo2'] = this.addInfo2;
    data['addInfo2Ar'] = this.addInfo2Ar;
    data['usercommentBm'] = this.usercommentBm;
    data['addInfo1Bm'] = this.addInfo1Bm;
    data['addInfo2Bm'] = this.addInfo2Bm;
    data['displayIndex'] = this.displayIndex;
    data['isSearchClick'] = this.isSearchClick;
    if (this.contentImages != null) {
      data['contentImages'] =
          this.contentImages!.map((v) => v.toJson()).toList();
    }
    data['isAddedToWatchList'] = this.isAddedToWatchList;
    data['infoDisplay'] = this.infoDisplay;
    data['usercommentDisplay'] = this.usercommentDisplay;
    data['languageId'] = this.languageId;
    data['webpreview'] = this.webpreview;
    return data;
  }
}

class ContentImages {
  int? id;
  int? contentId;
  String? layoutName;
  String? contextPath;
  String? status;
  String? fileName;

  ContentImages(
      {this.id,
      this.contentId,
      this.layoutName,
      this.contextPath,
      this.status,
      this.fileName});

  ContentImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentId = json['contentId'];
    layoutName = json['layoutName'];
    contextPath = json['contextPath'];
    status = json['status'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contentId'] = this.contentId;
    data['layoutName'] = this.layoutName;
    data['contextPath'] = this.contextPath;
    data['status'] = this.status;
    data['fileName'] = this.fileName;
    return data;
  }
}
