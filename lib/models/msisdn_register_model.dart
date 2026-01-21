class MsisdnRegisterModel {
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
  String? msisdn;
  String? source;
  String? mode;
  String? fcm;
  String? language;

  MsisdnRegisterModel(
      {this.mncCode,
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
        this.msisdn,
        this.source,
        this.mode,
        this.fcm,
        this.language});

  MsisdnRegisterModel.fromJson(Map<String, dynamic> json) {
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
    msisdn = json['msisdn'];
    source = json['source'];
    mode = json['mode'];
    fcm = json['fcm'];
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
    data['msisdn'] = this.msisdn;
    data['source'] = this.source;
    data['mode'] = this.mode;
    data['fcm'] = this.fcm;
    data['language'] = this.language;
    return data;
  }
}
