class StreamResponse {
  ResponseDescription? responseDescription;
  Content? content;

  StreamResponse({this.responseDescription, this.content});

  StreamResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
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

class Content {
  int? id;
  int? cpid;
  int? itemtype;
  String? title;
  String? titledesc;
  String? titleAr;
  String? titledescAr;
  String? rank;
  int? status;
  String? uploadtime;
  String? cpcatnr;
  String? album;
  String? parentpath;
  String? webpreview;
  String? totaluserrating;
  int? differentialBilling;
  int? language;
  int? totalDuration;
  int? durationElapsed;
  String? titleDisplay;
  String? titledescDisplay;
  StreamWrapper? streamWrapper;
  String? streamSource;

  Content(
      {this.id,
      this.cpid,
      this.itemtype,
      this.title,
      this.titledesc,
      this.titleAr,
      this.titledescAr,
      this.rank,
      this.status,
      this.uploadtime,
      this.cpcatnr,
      this.album,
      this.parentpath,
      this.webpreview,
      this.totaluserrating,
      this.differentialBilling,
      this.language,
      this.totalDuration,
      this.durationElapsed,
      this.titleDisplay,
      this.titledescDisplay,
      this.streamWrapper,
      this.streamSource});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cpid = json['cpid'];
    itemtype = json['itemtype'];
    title = json['title'];
    titledesc = json['titledesc'];
    titleAr = json['titleAr'];
    titledescAr = json['titledescAr'];
    rank = json['rank'];
    status = json['status'];
    uploadtime = json['uploadtime'];
    cpcatnr = json['cpcatnr'];
    album = json['album'];
    parentpath = json['parentpath'];
    webpreview = json['webpreview'];
    totaluserrating = json['totaluserrating'];
    differentialBilling = json['differential_billing'];
    language = json['language'];
    totalDuration = json['totalDuration'];
    durationElapsed = json['durationElapsed'];
    titleDisplay = json['titleDisplay'];
    titledescDisplay = json['titledescDisplay'];
    streamWrapper = json['streamWrapper'] != null
        ? new StreamWrapper.fromJson(json['streamWrapper'])
        : null;
    streamSource = json['streamSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cpid'] = this.cpid;
    data['itemtype'] = this.itemtype;
    data['title'] = this.title;
    data['titledesc'] = this.titledesc;
    data['titleAr'] = this.titleAr;
    data['titledescAr'] = this.titledescAr;
    data['rank'] = this.rank;
    data['status'] = this.status;
    data['uploadtime'] = this.uploadtime;
    data['cpcatnr'] = this.cpcatnr;
    data['album'] = this.album;
    data['parentpath'] = this.parentpath;
    data['webpreview'] = this.webpreview;
    data['totaluserrating'] = this.totaluserrating;
    data['differential_billing'] = this.differentialBilling;
    data['language'] = this.language;
    data['totalDuration'] = this.totalDuration;
    data['durationElapsed'] = this.durationElapsed;
    data['titleDisplay'] = this.titleDisplay;
    data['titledescDisplay'] = this.titledescDisplay;
    if (this.streamWrapper != null) {
      data['streamWrapper'] = this.streamWrapper!.toJson();
    }
    data['streamSource'] = this.streamSource;
    return data;
  }
}

class StreamWrapper {
  Play? play;

  StreamWrapper({this.play});

  StreamWrapper.fromJson(Map<String, dynamic> json) {
    play = json['play'] != null ? new Play.fromJson(json['play']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.play != null) {
      data['play'] = this.play!.toJson();
    }
    return data;
  }
}

class Play {
  List<Progressive>? progressive;
  Dash? dash;
  Dash? hls;
  String? status;

  Play({this.progressive, this.dash, this.hls, this.status});

  Play.fromJson(Map<String, dynamic> json) {
    if (json['progressive'] != null) {
      progressive = <Progressive>[];
      json['progressive'].forEach((v) {
        progressive!.add(new Progressive.fromJson(v));
      });
    }
    dash = json['dash'] != null ? new Dash.fromJson(json['dash']) : null;
    hls = json['hls'] != null ? new Dash.fromJson(json['hls']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.progressive != null) {
      data['progressive'] = this.progressive!.map((v) => v.toJson()).toList();
    }
    if (this.dash != null) {
      data['dash'] = this.dash!.toJson();
    }
    if (this.hls != null) {
      data['hls'] = this.hls!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Progressive {
  String? codec;
  String? createdTime;
  String? size;
  String? rendition;
  String? width;
  String? link;
  String? fps;
  String? linkExpirationTime;
  String? type;
  String? height;
  Null? md5;

  Progressive(
      {this.codec,
      this.createdTime,
      this.size,
      this.rendition,
      this.width,
      this.link,
      this.fps,
      this.linkExpirationTime,
      this.type,
      this.height,
      this.md5});

  Progressive.fromJson(Map<String, dynamic> json) {
    codec = json['codec'];
    createdTime = json['created_time'];
    size = json['size'];
    rendition = json['rendition'];
    width = json['width'];
    link = json['link'];
    fps = json['fps'];
    linkExpirationTime = json['link_expiration_time'];
    type = json['type'];
    height = json['height'];
    md5 = json['md5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codec'] = this.codec;
    data['created_time'] = this.createdTime;
    data['size'] = this.size;
    data['rendition'] = this.rendition;
    data['width'] = this.width;
    data['link'] = this.link;
    data['fps'] = this.fps;
    data['link_expiration_time'] = this.linkExpirationTime;
    data['type'] = this.type;
    data['height'] = this.height;
    data['md5'] = this.md5;
    return data;
  }
}

class Dash {
  String? link;
  String? linkExpirationTime;

  Dash({this.link, this.linkExpirationTime});

  Dash.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    linkExpirationTime = json['link_expiration_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['link_expiration_time'] = this.linkExpirationTime;
    return data;
  }
}
