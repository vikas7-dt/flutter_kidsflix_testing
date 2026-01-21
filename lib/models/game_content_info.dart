class GameContentInfo {
  ResponseDescription? responseDescription;
  PortalSubContent? portalSubContent;

  GameContentInfo({this.responseDescription, this.portalSubContent});

  GameContentInfo.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    portalSubContent = json['portalSubContent'] != null
        ? new PortalSubContent.fromJson(json['portalSubContent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.portalSubContent != null) {
      data['portalSubContent'] = this.portalSubContent!.toJson();
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

class PortalSubContent {
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
  int? cpId;
  String? album;
  bool? isDebug;
  String? isActive;
  Content? content;
  String? infoAr;
  String? infoBm;
  String? usercommentAr;
  String? addInfo1;
  String? usercommentBm;
  String? addInfo1Bm;
  int? displayIndex;
  bool? isSearchClick;
  bool? isAddedToWatchList;
  String? infoDisplay;
  String? usercommentDisplay;
  int? languageId;

  PortalSubContent(
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
      this.cpId,
      this.album,
      this.isDebug,
      this.isActive,
      this.content,
      this.infoAr,
      this.infoBm,
      this.usercommentAr,
      this.addInfo1,
      this.usercommentBm,
      this.addInfo1Bm,
      this.displayIndex,
      this.isSearchClick,
      this.isAddedToWatchList,
      this.infoDisplay,
      this.usercommentDisplay,
      this.languageId});

  PortalSubContent.fromJson(Map<String, dynamic> json) {
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
    cpId = json['cpId'];
    album = json['album'];
    isDebug = json['isDebug'];
    isActive = json['isActive'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    infoAr = json['infoAr'];
    infoBm = json['infoBm'];
    usercommentAr = json['usercommentAr'];
    addInfo1 = json['addInfo1'];
    usercommentBm = json['usercommentBm'];
    addInfo1Bm = json['addInfo1Bm'];
    displayIndex = json['displayIndex'];
    isSearchClick = json['isSearchClick'];
    isAddedToWatchList = json['isAddedToWatchList'];
    infoDisplay = json['infoDisplay'];
    usercommentDisplay = json['usercommentDisplay'];
    languageId = json['languageId'];
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
    data['cpId'] = this.cpId;
    data['album'] = this.album;
    data['isDebug'] = this.isDebug;
    data['isActive'] = this.isActive;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['infoAr'] = this.infoAr;
    data['infoBm'] = this.infoBm;
    data['usercommentAr'] = this.usercommentAr;
    data['addInfo1'] = this.addInfo1;
    data['usercommentBm'] = this.usercommentBm;
    data['addInfo1Bm'] = this.addInfo1Bm;
    data['displayIndex'] = this.displayIndex;
    data['isSearchClick'] = this.isSearchClick;
    data['isAddedToWatchList'] = this.isAddedToWatchList;
    data['infoDisplay'] = this.infoDisplay;
    data['usercommentDisplay'] = this.usercommentDisplay;
    data['languageId'] = this.languageId;
    return data;
  }
}

class Content {
  int? id;
  int? cpid;
  int? itemtype;
  String? title;
  String? titledesc;
  String? titleAr;
  String? titledescAr;
  String? rank;
  int? status;
  String? uploadtime;
  String? cpcatnr;
  String? album;
  String? parentpath;
  String? webpreview;
  String? searchkeyword;
  dynamic currentrating;
  String? totaluserrating;
  int? differentialBilling;
  int? language;
  int? totalDuration;
  String? titleDisplay;
  String? titledescDisplay;

  Content(
      {this.id,
      this.cpid,
      this.itemtype,
      this.title,
      this.titledesc,
      this.titleAr,
      this.titledescAr,
      this.rank,
      this.status,
      this.uploadtime,
      this.cpcatnr,
      this.album,
      this.parentpath,
      this.webpreview,
      this.searchkeyword,
      this.currentrating,
      this.totaluserrating,
      this.differentialBilling,
      this.language,
      this.totalDuration,
      this.titleDisplay,
      this.titledescDisplay});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cpid = json['cpid'];
    itemtype = json['itemtype'];
    title = json['title'];
    titledesc = json['titledesc'];
    titleAr = json['titleAr'];
    titledescAr = json['titledescAr'];
    rank = json['rank'];
    status = json['status'];
    uploadtime = json['uploadtime'];
    cpcatnr = json['cpcatnr'];
    album = json['album'];
    parentpath = json['parentpath'];
    webpreview = json['webpreview'];
    searchkeyword = json['searchkeyword'];
    currentrating = json['currentrating'];
    totaluserrating = json['totaluserrating'];
    differentialBilling = json['differential_billing'];
    language = json['language'];
    totalDuration = json['totalDuration'];
    titleDisplay = json['titleDisplay'];
    titledescDisplay = json['titledescDisplay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cpid'] = this.cpid;
    data['itemtype'] = this.itemtype;
    data['title'] = this.title;
    data['titledesc'] = this.titledesc;
    data['titleAr'] = this.titleAr;
    data['titledescAr'] = this.titledescAr;
    data['rank'] = this.rank;
    data['status'] = this.status;
    data['uploadtime'] = this.uploadtime;
    data['cpcatnr'] = this.cpcatnr;
    data['album'] = this.album;
    data['parentpath'] = this.parentpath;
    data['webpreview'] = this.webpreview;
    data['searchkeyword'] = this.searchkeyword;
    data['currentrating'] = this.currentrating;
    data['totaluserrating'] = this.totaluserrating;
    data['differential_billing'] = this.differentialBilling;
    data['language'] = this.language;
    data['totalDuration'] = this.totalDuration;
    data['titleDisplay'] = this.titleDisplay;
    data['titledescDisplay'] = this.titledescDisplay;
    return data;
  }
}
