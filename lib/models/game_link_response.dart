class GameLinkResponse {
  ResponseDescription? responseDescription;
  GamesAccess? gamesAccess;

  GameLinkResponse({this.responseDescription, this.gamesAccess});

  GameLinkResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    gamesAccess = json['gamesAccess'] != null
        ? new GamesAccess.fromJson(json['gamesAccess'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.gamesAccess != null) {
      data['gamesAccess'] = this.gamesAccess!.toJson();
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

class GamesAccess {
  int? id;
  String? msisdn;
  String? dateTime;
  String? contentId;
  String? token;
  String? portalId;
  String? status;
  String? language;
  String? userAgent;
  String? os;
  String? osVersion;
  String? browser;
  String? browserVersion;
  String? device;
  String? deviceType;
  String? orientation;
  String? isTablet;
  String? isMobile;
  String? isDesktop;
  String? hostName;
  String? gameAccessUrl;
  String? traceId;
  String? requestId;
  bool? isDebug;

  GamesAccess(
      {this.id,
      this.msisdn,
      this.dateTime,
      this.contentId,
      this.token,
      this.portalId,
      this.status,
      this.language,
      this.userAgent,
      this.os,
      this.osVersion,
      this.browser,
      this.browserVersion,
      this.device,
      this.deviceType,
      this.orientation,
      this.isTablet,
      this.isMobile,
      this.isDesktop,
      this.hostName,
      this.gameAccessUrl,
      this.traceId,
      this.requestId,
      this.isDebug});

  GamesAccess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msisdn = json['msisdn'];
    dateTime = json['dateTime'];
    contentId = json['contentId'];
    token = json['token'];
    portalId = json['portalId'];
    status = json['status'];
    language = json['language'];
    userAgent = json['userAgent'];
    os = json['os'];
    osVersion = json['osVersion'];
    browser = json['browser'];
    browserVersion = json['browserVersion'];
    device = json['device'];
    deviceType = json['deviceType'];
    orientation = json['orientation'];
    isTablet = json['isTablet'];
    isMobile = json['isMobile'];
    isDesktop = json['isDesktop'];
    hostName = json['hostName'];
    gameAccessUrl = json['gameAccessUrl'];
    traceId = json['traceId'];
    requestId = json['requestId'];
    isDebug = json['isDebug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msisdn'] = this.msisdn;
    data['dateTime'] = this.dateTime;
    data['contentId'] = this.contentId;
    data['token'] = this.token;
    data['portalId'] = this.portalId;
    data['status'] = this.status;
    data['language'] = this.language;
    data['userAgent'] = this.userAgent;
    data['os'] = this.os;
    data['osVersion'] = this.osVersion;
    data['browser'] = this.browser;
    data['browserVersion'] = this.browserVersion;
    data['device'] = this.device;
    data['deviceType'] = this.deviceType;
    data['orientation'] = this.orientation;
    data['isTablet'] = this.isTablet;
    data['isMobile'] = this.isMobile;
    data['isDesktop'] = this.isDesktop;
    data['hostName'] = this.hostName;
    data['gameAccessUrl'] = this.gameAccessUrl;
    data['traceId'] = this.traceId;
    data['requestId'] = this.requestId;
    data['isDebug'] = this.isDebug;
    return data;
  }
}
