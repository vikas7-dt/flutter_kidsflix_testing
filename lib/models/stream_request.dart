class StreamRequest {
  String? portalId;
  String? contentId;
  String? language;
  String? userAgent;
  String? os;
  String? osVersion;
  String? browser;
  String? browserVersion;
  String? device;
  String? deviceType;
  String? orientation;
  bool? isTablet;
  bool? isDebug;
  bool? isMobile;
  bool? isDesktop;

  StreamRequest(
      {this.portalId,
      this.contentId,
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
      this.isDebug,
      this.isMobile,
      this.isDesktop});

  StreamRequest.fromJson(Map<String, dynamic> json) {
    portalId = json['portalId'];
    contentId = json['contentId'];
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
    isDebug = json['isDebug'];
    isMobile = json['isMobile'];
    isDesktop = json['isDesktop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portalId'] = this.portalId;
    data['contentId'] = this.contentId;
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
    data['isDebug'] = this.isDebug;
    data['isMobile'] = this.isMobile;
    data['isDesktop'] = this.isDesktop;
    return data;
  }
}
