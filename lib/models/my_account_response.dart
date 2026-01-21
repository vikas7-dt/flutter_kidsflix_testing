class MyAccountResponse {
  ResponseDescription? responseDescription;
  Users? users;

  MyAccountResponse({this.responseDescription, this.users});

  MyAccountResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users!.toJson();
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

class Users {
  int? id;
  String? msisdn;
  String? country;
  String? dateTime;
  String? lastSeenDateTime;
  String? mode;
  int? notificationFlag;
  String? deviceOs;
  String? deviceName;
  String? language;
  String? loginStatus;
  String? logoutDateTime;
  String? videoQuality;
  String? appId;
  String? regMode;
  List<UserTokens>? userTokens;
  Subscriber? subscriber;

  Users(
      {this.id,
        this.msisdn,
        this.country,
        this.dateTime,
        this.lastSeenDateTime,
        this.mode,
        this.notificationFlag,
        this.deviceOs,
        this.deviceName,
        this.language,
        this.loginStatus,
        this.logoutDateTime,
        this.videoQuality,
        this.appId,
        this.regMode,
        this.userTokens,
        this.subscriber});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msisdn = json['msisdn'];
    country = json['country'];
    dateTime = json['dateTime'];
    lastSeenDateTime = json['lastSeenDateTime'];
    mode = json['mode'];
    notificationFlag = json['notificationFlag'];
    deviceOs = json['deviceOs'];
    deviceName = json['deviceName'];
    language = json['language'];
    loginStatus = json['loginStatus'];
    logoutDateTime = json['logoutDateTime'];
    videoQuality = json['videoQuality'];
    appId = json['appId'];
    regMode = json['regMode'];
    if (json['userTokens'] != null) {
      userTokens = <UserTokens>[];
      json['userTokens'].forEach((v) {
        userTokens!.add(new UserTokens.fromJson(v));
      });
    }
    subscriber = json['subscriber'] != null
        ? new Subscriber.fromJson(json['subscriber'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msisdn'] = this.msisdn;
    data['country'] = this.country;
    data['dateTime'] = this.dateTime;
    data['lastSeenDateTime'] = this.lastSeenDateTime;
    data['mode'] = this.mode;
    data['notificationFlag'] = this.notificationFlag;
    data['deviceOs'] = this.deviceOs;
    data['deviceName'] = this.deviceName;
    data['language'] = this.language;
    data['loginStatus'] = this.loginStatus;
    data['logoutDateTime'] = this.logoutDateTime;
    data['videoQuality'] = this.videoQuality;
    data['appId'] = this.appId;
    data['regMode'] = this.regMode;
    if (this.userTokens != null) {
      data['userTokens'] = this.userTokens!.map((v) => v.toJson()).toList();
    }
    if (this.subscriber != null) {
      data['subscriber'] = this.subscriber!.toJson();
    }
    return data;
  }
}

class UserTokens {
  int? id;
  int? uid;
  String? source;
  String? accessToken;
  String? accessRefreshToken;

  UserTokens(
      {this.id,
        this.uid,
        this.source,
        this.accessToken,
        this.accessRefreshToken});

  UserTokens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    source = json['source'];
    accessToken = json['accessToken'];
    accessRefreshToken = json['accessRefreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['source'] = this.source;
    data['accessToken'] = this.accessToken;
    data['accessRefreshToken'] = this.accessRefreshToken;
    return data;
  }
}

class Subscriber {
  String? msisdn;
  String? subscriptionDate;
  String? channel;
  String? status;
  String? chargeDate;
  String? expiryDate;
  String? subSource;
  String? language;

  Subscriber(
      {this.msisdn,
        this.subscriptionDate,
        this.channel,
        this.status,
        this.chargeDate,
        this.expiryDate,
        this.subSource,
        this.language});

  Subscriber.fromJson(Map<String, dynamic> json) {
    msisdn = json['msisdn'];
    subscriptionDate = json['subscriptionDate'];
    channel = json['channel'];
    status = json['status'];
    chargeDate = json['chargeDate'];
    expiryDate = json['expiryDate'];
    subSource = json['subSource'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msisdn'] = this.msisdn;
    data['subscriptionDate'] = this.subscriptionDate;
    data['channel'] = this.channel;
    data['status'] = this.status;
    data['chargeDate'] = this.chargeDate;
    data['expiryDate'] = this.expiryDate;
    data['subSource'] = this.subSource;
    data['language'] = this.language;
    return data;
  }
}
