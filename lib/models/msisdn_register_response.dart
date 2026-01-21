class MsisdnRegisterResponse {
  ResponseDescription? responseDescription;
  Users? users;

  MsisdnRegisterResponse({this.responseDescription, this.users});

  MsisdnRegisterResponse.fromJson(Map<String, dynamic> json) {
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
  String? mncCode;
  String? mccCode;
  String? mode;
  String? deviceOs;
  String? deviceName;
  String? deviceOsVersion;
  String? language;
  String? loginStatus;
  String? appId;
  String? regMode;
  List<UserTokens>? userTokens;

  Users(
      {this.id,
        this.msisdn,
        this.country,
        this.dateTime,
        this.lastSeenDateTime,
        this.mncCode,
        this.mccCode,
        this.mode,
        this.deviceOs,
        this.deviceName,
        this.deviceOsVersion,
        this.language,
        this.loginStatus,
        this.appId,
        this.regMode,
        this.userTokens});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msisdn = json['msisdn'];
    country = json['country'];
    dateTime = json['dateTime'];
    lastSeenDateTime = json['lastSeenDateTime'];
    mncCode = json['mncCode'];
    mccCode = json['mccCode'];
    mode = json['mode'];
    deviceOs = json['deviceOs'];
    deviceName = json['deviceName'];
    deviceOsVersion = json['deviceOsVersion'];
    language = json['language'];
    loginStatus = json['loginStatus'];
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
    data['msisdn'] = this.msisdn;
    data['country'] = this.country;
    data['dateTime'] = this.dateTime;
    data['lastSeenDateTime'] = this.lastSeenDateTime;
    data['mncCode'] = this.mncCode;
    data['mccCode'] = this.mccCode;
    data['mode'] = this.mode;
    data['deviceOs'] = this.deviceOs;
    data['deviceName'] = this.deviceName;
    data['deviceOsVersion'] = this.deviceOsVersion;
    data['language'] = this.language;
    data['loginStatus'] = this.loginStatus;
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
