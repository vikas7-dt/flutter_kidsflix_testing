class SearchQueryResponse {
  ResponseDescription? responseDescription;
  List<SearchResult>? searchResult;

  SearchQueryResponse({this.responseDescription, this.searchResult});

  SearchQueryResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['searchResult'] != null) {
      searchResult = <SearchResult>[];
      json['searchResult'].forEach((v) {
        searchResult!.add(new SearchResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.searchResult != null) {
      data['searchResult'] = this.searchResult!.map((v) => v.toJson()).toList();
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

class SearchResult {
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
  int? itemtype;
  String? url;
  String? tagurl;

  SearchResult(
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
      this.itemtype,
      this.url,
      this.tagurl});

  SearchResult.fromJson(Map<String, dynamic> json) {
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
    itemtype = json['itemtype'];
    url = json['url'];
    tagurl = json['tagurl'];
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
    data['itemtype'] = this.itemtype;
    data['url'] = this.url;
    data['tagurl'] = this.tagurl;
    return data;
  }
}
