class NotificationResponse {
  ResponseDescription? responseDescription;
  List<NotificationHistoryList>? notificationHistoryList;

  NotificationResponse(
      {this.responseDescription, this.notificationHistoryList});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['notificationHistoryList'] != null) {
      notificationHistoryList = <NotificationHistoryList>[];
      json['notificationHistoryList'].forEach((v) {
        notificationHistoryList!.add(new NotificationHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.notificationHistoryList != null) {
      data['notificationHistoryList'] =
          this.notificationHistoryList!.map((v) => v.toJson()).toList();
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

class NotificationHistoryList {
  int? id;
  int? userId;
  String? countryId;
  String? dateTime;
  String? notificationType;
  String? notificationBody;
  String? notificationTitle;
  String? imageUrl;
  String? notificationData;
  String? multicastId;
  int? success;
  int? failure;
  int? canonicalIds;
  String? messageId;
  int? readFlag;

  NotificationHistoryList(
      {this.id,
      this.userId,
      this.countryId,
      this.dateTime,
      this.notificationType,
      this.notificationBody,
      this.notificationTitle,
      this.imageUrl,
      this.notificationData,
      this.multicastId,
      this.success,
      this.failure,
      this.canonicalIds,
      this.messageId,
      this.readFlag});

  NotificationHistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    countryId = json['countryId'];
    dateTime = json['dateTime'];
    notificationType = json['notificationType'];
    notificationBody = json['notificationBody'];
    notificationTitle = json['notificationTitle'];
    imageUrl = json['imageUrl'];
    notificationData = json['notificationData'];
    multicastId = json['multicastId'];
    success = json['success'];
    failure = json['failure'];
    canonicalIds = json['canonicalIds'];
    messageId = json['messageId'];
    readFlag = json['readFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['countryId'] = this.countryId;
    data['dateTime'] = this.dateTime;
    data['notificationType'] = this.notificationType;
    data['notificationBody'] = this.notificationBody;
    data['notificationTitle'] = this.notificationTitle;
    data['imageUrl'] = this.imageUrl;
    data['notificationData'] = this.notificationData;
    data['multicastId'] = this.multicastId;
    data['success'] = this.success;
    data['failure'] = this.failure;
    data['canonicalIds'] = this.canonicalIds;
    data['messageId'] = this.messageId;
    data['readFlag'] = this.readFlag;
    return data;
  }
}
