class GameLinkRequest {
  var browser = "";
  var browserVersion = "118.0";
  var contentId = "";
  var device = "";
  var deviceType = "mobile";
  var hostName = "app";
  var isDesktop = false;
  var isMobile = false;
  var isTablet = false;
  var language = "en";
  var orientation = "landscape";
  var os = "android";
  var osVersion = "10";
  var portalId = "";
  var userAgent = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hostName'] = this.hostName;
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
    data['isMobile'] = this.isMobile;
    data['isDesktop'] = this.isDesktop;
    return data;
  }
}
