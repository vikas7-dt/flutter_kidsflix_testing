class ContinueWatchResponse {
  ResponseDescription? responseDescription;
  List<WatchOngoingList>? watchOngoingList;

  ContinueWatchResponse({this.responseDescription, this.watchOngoingList});

  ContinueWatchResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['watchOngoingList'] != null) {
      watchOngoingList = <WatchOngoingList>[];
      json['watchOngoingList'].forEach((v) {
        watchOngoingList!.add(new WatchOngoingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.watchOngoingList != null) {
      data['watchOngoingList'] =
          this.watchOngoingList!.map((v) => v.toJson()).toList();
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

class WatchOngoingList {
  bool? completeFlag;
  String? contentCategory;
  int? contentId;
  String? contentImageUrl;
  List<ContentImagess>? contentImages;
  String? contentName;
  String? dateTime;
  int? durationElapsed;
  int? id;
  String? lastUpdateDateTime;
  int? profileId;
  int? progress;
  String? source;
  int? totalDuration;
  int? userId;

  WatchOngoingList(
      {this.completeFlag,
        this.contentCategory,
        this.contentId,
        this.contentImageUrl,
        this.contentImages,
        this.contentName,
        this.dateTime,
        this.durationElapsed,
        this.id,
        this.lastUpdateDateTime,
        this.profileId,
        this.progress,
        this.source,
        this.totalDuration,
        this.userId});

  WatchOngoingList.fromJson(Map<String, dynamic> json) {
    completeFlag = json['completeFlag'];
    contentCategory = json['contentCategory'];
    contentId = json['contentId'];
    contentImageUrl = json['contentImageUrl'];
    if (json['contentImages'] != null) {
      contentImages = <ContentImagess>[];
      json['contentImages'].forEach((v) {
        contentImages!.add(new ContentImagess.fromJson(v));
      });
    }
    contentName = json['contentName'];
    dateTime = json['dateTime'];
    durationElapsed = json['durationElapsed'];
    id = json['id'];
    lastUpdateDateTime = json['lastUpdateDateTime'];
    profileId = json['profileId'];
    progress = json['progress'];
    source = json['source'];
    totalDuration = json['totalDuration'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completeFlag'] = this.completeFlag;
    data['contentCategory'] = this.contentCategory;
    data['contentId'] = this.contentId;
    data['contentImageUrl'] = this.contentImageUrl;
    if (this.contentImages != null) {
      data['contentImages'] =
          this.contentImages!.map((v) => v.toJson()).toList();
    }
    data['contentName'] = this.contentName;
    data['dateTime'] = this.dateTime;
    data['durationElapsed'] = this.durationElapsed;
    data['id'] = this.id;
    data['lastUpdateDateTime'] = this.lastUpdateDateTime;
    data['profileId'] = this.profileId;
    data['progress'] = this.progress;
    data['source'] = this.source;
    data['totalDuration'] = this.totalDuration;
    data['userId'] = this.userId;
    return data;
  }
}

class ContentImagess {
  int? contentId;
  String? contextPath;
  String? fileName;
  int? id;
  String? layoutName;
  String? status;

  ContentImagess(
      {this.contentId,
        this.contextPath,
        this.fileName,
        this.id,
        this.layoutName,
        this.status});

  ContentImagess.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    contextPath = json['contextPath'];
    fileName = json['fileName'];
    id = json['id'];
    layoutName = json['layoutName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentId'] = this.contentId;
    data['contextPath'] = this.contextPath;
    data['fileName'] = this.fileName;
    data['id'] = this.id;
    data['layoutName'] = this.layoutName;
    data['status'] = this.status;
    return data;
  }
}
