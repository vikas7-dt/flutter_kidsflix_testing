class GmailRegisterModel {
  String? mncCode;
  String? mccCode;
  String? countryId;
  String? browser;
  String? browserVersion;
  String? device;
  String? deviceType;
  String? orientation;
  String? os;
  String? osVersion;
  String? isMobile;
  String? requestId;
  String? email;
  String? source;
  String? mode;
  String? fcm;
  String? language;

  GmailRegisterModel(
      {
        this.mncCode,
        this.mccCode,
        this.countryId,
        this.browser,
        this.browserVersion,
        this.device,
        this.deviceType,
        this.orientation,
        this.os,
        this.osVersion,
        this.isMobile,
        this.requestId,
        this.email,
        this.source,
        this.mode,
        this.fcm,
        this.language});

  GmailRegisterModel.fromJson(Map<String, dynamic> json) {
    mncCode = json['mncCode'];
    mccCode = json['mccCode'];
    countryId = json['countryId'];
    browser = json['browser'];
    browserVersion = json['browserVersion'];
    device = json['device'];
    deviceType = json['deviceType'];
    orientation = json['orientation'];
    os = json['os'];
    osVersion = json['osVersion'];
    isMobile = json['isMobile'];
    requestId = json['requestId'];
    email = json['email'];
    source = json['source'];
    fcm = json['fcm'];
    mode = json['mode'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mncCode'] = this.mncCode;
    data['mccCode'] = this.mccCode;
    data['countryId'] = this.countryId;
    data['browser'] = this.browser;
    data['browserVersion'] = this.browserVersion;
    data['device'] = this.device;
    data['deviceType'] = this.deviceType;
    data['orientation'] = this.orientation;
    data['os'] = this.os;
    data['osVersion'] = this.osVersion;
    data['isMobile'] = this.isMobile;
    data['requestId'] = this.requestId;
    data['email'] = this.email;
    data['source'] = this.source;
    data['fcm'] = this.fcm;
    data['mode'] = this.mode;
    data['language'] = this.language;
    return data;
  }
}
