class AvatarResponse {
  ResponseDescription? responseDescription;
  List<Avtars>? avtars;

  AvatarResponse({this.responseDescription, this.avtars});

  AvatarResponse.fromJson(Map<String, dynamic> json) {
    responseDescription = json['responseDescription'] != null
        ? new ResponseDescription.fromJson(json['responseDescription'])
        : null;
    if (json['avtars'] != null) {
      avtars = <Avtars>[];
      json['avtars'].forEach((v) {
        avtars!.add(new Avtars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseDescription != null) {
      data['responseDescription'] = this.responseDescription!.toJson();
    }
    if (this.avtars != null) {
      data['avtars'] = this.avtars!.map((v) => v.toJson()).toList();
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

class Avtars {
  int? id;
  String? avtarName;
  String? avtarUrl;
  String? status;
  String? avtarFileName;
  String? avtarContextPath;
  String? avtarFilePath;

  Avtars(
      {this.id,
      this.avtarName,
      this.avtarUrl,
      this.status,
      this.avtarFileName,
      this.avtarContextPath,
      this.avtarFilePath});

  Avtars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avtarName = json['avtarName'];
    avtarUrl = json['avtarUrl'];
    status = json['status'];
    avtarFileName = json['avtarFileName'];
    avtarContextPath = json['avtarContextPath'];
    avtarFilePath = json['avtarFilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avtarName'] = this.avtarName;
    data['avtarUrl'] = this.avtarUrl;
    data['status'] = this.status;
    data['avtarFileName'] = this.avtarFileName;
    data['avtarContextPath'] = this.avtarContextPath;
    data['avtarFilePath'] = this.avtarFilePath;
    return data;
  }
}
