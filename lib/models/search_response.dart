class SearchResponse {
  ResponseDescription? responseDescription;
  List<PublishMasters>? publishMasters;

  SearchResponse({this.responseDescription, this.publishMasters});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['publishMasters'] != null) {
      publishMasters = <PublishMasters>[];
      json['publishMasters'].forEach((v) {
        publishMasters!.add(new PublishMasters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.publishMasters != null) {
      data['publishMasters'] =
          this.publishMasters!.map((v) => v.toJson()).toList();
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

class PublishMasters {
  int? id;
  int? portalId;
  int? parentId;
  int? pageId;
  int? pubSubId;
  String? pageName;
  String? fromdate;
  String? todate;
  String? title;
  String? titleDisplay;
  int? langid;
  String? info;
  String? subPagePath;
  String? scheme;
  String? index;
  String? titlealias;
  int? acctype;
  String? operator;
  List<PortalContents>? portalContents;
  String? layoutName;

  PublishMasters(
      {this.id,
      this.portalId,
      this.parentId,
      this.pageId,
      this.pubSubId,
      this.pageName,
      this.fromdate,
      this.todate,
      this.title,
      this.titleDisplay,
      this.langid,
      this.info,
      this.subPagePath,
      this.scheme,
      this.index,
      this.titlealias,
      this.acctype,
      this.operator,
      this.portalContents,
      this.layoutName});

  PublishMasters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    portalId = json['portalId'];
    parentId = json['parentId'];
    pageId = json['pageId'];
    pubSubId = json['pubSubId'];
    pageName = json['pageName'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    title = json['title'];
    titleDisplay = json['titleDisplay'];
    langid = json['langid'];
    info = json['info'];
    subPagePath = json['subPagePath'];
    scheme = json['scheme'];
    index = json['index'];
    titlealias = json['titlealias'];
    acctype = json['acctype'];
    operator = json['operator'];
    if (json['portalContents'] != null) {
      portalContents = <PortalContents>[];
      json['portalContents'].forEach((v) {
        portalContents!.add(new PortalContents.fromJson(v));
      });
    }
    layoutName = json['layoutName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['portalId'] = this.portalId;
    data['parentId'] = this.parentId;
    data['pageId'] = this.pageId;
    data['pubSubId'] = this.pubSubId;
    data['pageName'] = this.pageName;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['title'] = this.title;
    data['titleDisplay'] = this.titleDisplay;
    data['langid'] = this.langid;
    data['info'] = this.info;
    data['subPagePath'] = this.subPagePath;
    data['scheme'] = this.scheme;
    data['index'] = this.index;
    data['titlealias'] = this.titlealias;
    data['acctype'] = this.acctype;
    data['operator'] = this.operator;
    if (this.portalContents != null) {
      data['portalContents'] =
          this.portalContents!.map((v) => v.toJson()).toList();
    }
    data['layoutName'] = this.layoutName;
    return data;
  }
}

class PortalContents {
  int? id;
  int? portalId;
  int? pageId;
  int? pubSubId;
  String? info;
  String? text;
  String? imagepage;
  String? contentId;
  String? fromdate;
  String? todate;
  String? pricepointid;
  String? usercomment;
  int? itemtype;
  String? album;
  bool? isDebug;
  String? isActive;
  String? infoAr;
  String? textAr;
  String? usercommentAr;
  String? addInfo1;
  String? addInfo1Ar;
  String? addInfo2;
  String? addInfo2Ar;
  int? displayIndex;
  String? searchKeyword;
  bool? isSearchClick;
  bool? isAddedToWatchList;
  String? infoDisplay;
  String? usercommentDisplay;
  int? languageId;
  String? url;
  String? parentpath;
  String? tagurl;
  String? infoBm;
  String? usercommentBm;
  String? addInfo1Bm;

  PortalContents(
      {this.id,
      this.portalId,
      this.pageId,
      this.pubSubId,
      this.info,
      this.text,
      this.imagepage,
      this.contentId,
      this.fromdate,
      this.todate,
      this.pricepointid,
      this.usercomment,
      this.itemtype,
      this.album,
      this.isDebug,
      this.isActive,
      this.infoAr,
      this.textAr,
      this.usercommentAr,
      this.addInfo1,
      this.addInfo1Ar,
      this.addInfo2,
      this.addInfo2Ar,
      this.displayIndex,
      this.searchKeyword,
      this.isSearchClick,
      this.isAddedToWatchList,
      this.infoDisplay,
      this.usercommentDisplay,
      this.languageId,
      this.url,
      this.parentpath,
      this.tagurl,
      this.infoBm,
      this.usercommentBm,
      this.addInfo1Bm});

  PortalContents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    portalId = json['portalId'];
    pageId = json['pageId'];
    pubSubId = json['pubSubId'];
    info = json['info'];
    text = json['text'];
    imagepage = json['imagepage'];
    contentId = json['contentId'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    pricepointid = json['pricepointid'];
    usercomment = json['usercomment'];
    itemtype = json['itemtype'];
    album = json['album'];
    isDebug = json['isDebug'];
    isActive = json['isActive'];
    infoAr = json['infoAr'];
    textAr = json['textAr'];
    usercommentAr = json['usercommentAr'];
    addInfo1 = json['addInfo1'];
    addInfo1Ar = json['addInfo1Ar'];
    addInfo2 = json['addInfo2'];
    addInfo2Ar = json['addInfo2Ar'];
    displayIndex = json['displayIndex'];
    searchKeyword = json['searchKeyword'];
    isSearchClick = json['isSearchClick'];
    isAddedToWatchList = json['isAddedToWatchList'];
    infoDisplay = json['infoDisplay'];
    usercommentDisplay = json['usercommentDisplay'];
    languageId = json['languageId'];
    url = json['url'];
    parentpath = json['parentpath'];
    tagurl = json['tagurl'];
    infoBm = json['infoBm'];
    usercommentBm = json['usercommentBm'];
    addInfo1Bm = json['addInfo1Bm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['portalId'] = this.portalId;
    data['pageId'] = this.pageId;
    data['pubSubId'] = this.pubSubId;
    data['info'] = this.info;
    data['text'] = this.text;
    data['imagepage'] = this.imagepage;
    data['contentId'] = this.contentId;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['pricepointid'] = this.pricepointid;
    data['usercomment'] = this.usercomment;
    data['itemtype'] = this.itemtype;
    data['album'] = this.album;
    data['isDebug'] = this.isDebug;
    data['isActive'] = this.isActive;
    data['infoAr'] = this.infoAr;
    data['textAr'] = this.textAr;
    data['usercommentAr'] = this.usercommentAr;
    data['addInfo1'] = this.addInfo1;
    data['addInfo1Ar'] = this.addInfo1Ar;
    data['addInfo2'] = this.addInfo2;
    data['addInfo2Ar'] = this.addInfo2Ar;
    data['displayIndex'] = this.displayIndex;
    data['searchKeyword'] = this.searchKeyword;
    data['isSearchClick'] = this.isSearchClick;
    data['isAddedToWatchList'] = this.isAddedToWatchList;
    data['infoDisplay'] = this.infoDisplay;
    data['usercommentDisplay'] = this.usercommentDisplay;
    data['languageId'] = this.languageId;
    data['url'] = this.url;
    data['parentpath'] = this.parentpath;
    data['tagurl'] = this.tagurl;
    data['infoBm'] = this.infoBm;
    data['usercommentBm'] = this.usercommentBm;
    data['addInfo1Bm'] = this.addInfo1Bm;
    return data;
  }
}
