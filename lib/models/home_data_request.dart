class HomeDataRequest {
  String? portalId;
  String? pageId;
  String? pageName;
  String? scheme;
  String? language;

  HomeDataRequest({this.portalId, this.pageId, this.pageName, this.scheme});

  HomeDataRequest.fromJson(Map<String, dynamic> json) {
    portalId = json['portalId'];
    pageId = json['pageId'];
    pageName = json['pageName'];
    scheme = json['scheme'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portalId'] = this.portalId;
    data['pageId'] = this.pageId;
    data['pageName'] = this.pageName;
    data['scheme'] = this.scheme;
    data['language'] = this.language  ;
    return data;
  }
}
