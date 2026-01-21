class WatchListResponse {
  ResponseDescription? responseDescription;
  List<KidsFlixWatchLists>? kidsFlixWatchLists;

  WatchListResponse({this.responseDescription, this.kidsFlixWatchLists});

  WatchListResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['kidsFlixWatchLists'] != null) {
      kidsFlixWatchLists = <KidsFlixWatchLists>[];
      json['kidsFlixWatchLists'].forEach((v) {
        kidsFlixWatchLists!.add(new KidsFlixWatchLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.kidsFlixWatchLists != null) {
      data['kidsFlixWatchLists'] =
          this.kidsFlixWatchLists!.map((v) => v.toJson()).toList();
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

class KidsFlixWatchLists {
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
  List<ContentImages>? contentImages;
  String? contentNameDisplay;

  KidsFlixWatchLists(
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
      this.contentImages,
      this.contentNameDisplay});

  KidsFlixWatchLists.fromJson(Map<String, dynamic> json) {
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
    if (json['contentImages'] != null) {
      contentImages = <ContentImages>[];
      json['contentImages'].forEach((v) {
        contentImages!.add(new ContentImages.fromJson(v));
      });
    }
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
    if (this.contentImages != null) {
      data['contentImages'] =
          this.contentImages!.map((v) => v.toJson()).toList();
    }
    data['contentNameDisplay'] = this.contentNameDisplay;
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
