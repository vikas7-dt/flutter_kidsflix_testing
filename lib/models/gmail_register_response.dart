class GmailRegisterResponse {
  ResponseDescription? responseDescription;
  Users? users;

  GmailRegisterResponse({this.responseDescription, this.users});

  GmailRegisterResponse.fromJson(Map<String, dynamic> json) {
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
  String? country;
  String? dateTime;
  String? lastSeenDateTime;
  String? email;
  String? mncCode;
  String? mccCode;
  String? mode;
  String? fcmToken;
  int? notificationFlag;
  String? deviceOs;
  String? deviceName;
  String? deviceOsVersion;
  String? avtarId;
  String? avtarUrl;
  String? language;
  String? loginStatus;
  String? logoutDateTime;
  String? videoQuality;
  String? appId;
  String? regMode;
  List<UserTokens>? userTokens;

  Users(
      {this.id,
        this.country,
        this.dateTime,
        this.lastSeenDateTime,
        this.email,
        this.mncCode,
        this.mccCode,
        this.mode,
        this.fcmToken,
        this.notificationFlag,
        this.deviceOs,
        this.deviceName,
        this.deviceOsVersion,
        this.avtarId,
        this.avtarUrl,
        this.language,
        this.loginStatus,
        this.logoutDateTime,
        this.videoQuality,
        this.appId,
        this.regMode,
        this.userTokens});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    dateTime = json['dateTime'];
    lastSeenDateTime = json['lastSeenDateTime'];
    email = json['email'];
    mncCode = json['mncCode'];
    mccCode = json['mccCode'];
    mode = json['mode'];
    fcmToken = json['fcmToken'];
    notificationFlag = json['notificationFlag'];
    deviceOs = json['deviceOs'];
    deviceName = json['deviceName'];
    deviceOsVersion = json['deviceOsVersion'];
    avtarId = json['avtarId'];
    avtarUrl = json['avtarUrl'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['dateTime'] = this.dateTime;
    data['lastSeenDateTime'] = this.lastSeenDateTime;
    data['email'] = this.email;
    data['mncCode'] = this.mncCode;
    data['mccCode'] = this.mccCode;
    data['mode'] = this.mode;
    data['fcmToken'] = this.fcmToken;
    data['notificationFlag'] = this.notificationFlag;
    data['deviceOs'] = this.deviceOs;
    data['deviceName'] = this.deviceName;
    data['deviceOsVersion'] = this.deviceOsVersion;
    data['avtarId'] = this.avtarId;
    data['avtarUrl'] = this.avtarUrl;
    data['language'] = this.language;
    data['loginStatus'] = this.loginStatus;
    data['logoutDateTime'] = this.logoutDateTime;
    data['videoQuality'] = this.videoQuality;
    data['appId'] = this.appId;
    data['regMode'] = this.regMode;
    if (this.userTokens != null) {
      data['userTokens'] = this.userTokens!.map((v) => v.toJson()).toList();
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
  String? accessTokenExpiry;
  String? accessRefreshTokenExpiry;

  UserTokens(
      {this.id,
        this.uid,
        this.source,
        this.accessToken,
        this.accessRefreshToken,
        this.accessTokenExpiry,
        this.accessRefreshTokenExpiry});

  UserTokens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    source = json['source'];
    accessToken = json['accessToken'];
    accessRefreshToken = json['accessRefreshToken'];
    accessTokenExpiry = json['accessTokenExpiry'];
    accessRefreshTokenExpiry = json['accessRefreshTokenExpiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['source'] = this.source;
    data['accessToken'] = this.accessToken;
    data['accessRefreshToken'] = this.accessRefreshToken;
    data['accessTokenExpiry'] = this.accessTokenExpiry;
    data['accessRefreshTokenExpiry'] = this.accessRefreshTokenExpiry;
    return data;
  }
}
