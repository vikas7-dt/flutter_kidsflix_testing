class AddWatchListResponse {
  ResponseDescription? responseDescription;
  KidsFlixWatchList? kidsFlixWatchList;

  AddWatchListResponse({this.responseDescription, this.kidsFlixWatchList});

  AddWatchListResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    kidsFlixWatchList = json['kidsFlixWatchList'] != null
        ? new KidsFlixWatchList.fromJson(json['kidsFlixWatchList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.kidsFlixWatchList != null) {
      data['kidsFlixWatchList'] = this.kidsFlixWatchList!.toJson();
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

class KidsFlixWatchList {
  int? id;
  int? userId;
  int? profileId;
  int? contentId;
  String? contentName;
  String? contentCategory;
  String? contentImageUrl;
  String? dateTime;
  String? source;
  int? contentDuration;
  String? contentNameDisplay;

  KidsFlixWatchList(
      {this.id,
      this.userId,
      this.profileId,
      this.contentId,
      this.contentName,
      this.contentCategory,
      this.contentImageUrl,
      this.dateTime,
      this.source,
      this.contentDuration,
      this.contentNameDisplay});

  KidsFlixWatchList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    profileId = json['profileId'];
    contentId = json['contentId'];
    contentName = json['contentName'];
    contentCategory = json['contentCategory'];
    contentImageUrl = json['contentImageUrl'];
    dateTime = json['dateTime'];
    source = json['source'];
    contentDuration = json['contentDuration'];
    contentNameDisplay = json['contentNameDisplay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['profileId'] = this.profileId;
    data['contentId'] = this.contentId;
    data['contentName'] = this.contentName;
    data['contentCategory'] = this.contentCategory;
    data['contentImageUrl'] = this.contentImageUrl;
    data['dateTime'] = this.dateTime;
    data['source'] = this.source;
    data['contentDuration'] = this.contentDuration;
    data['contentNameDisplay'] = this.contentNameDisplay;
    return data;
  }
}
