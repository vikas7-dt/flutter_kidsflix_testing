class BannerRequest {
  String pageId = "";
  String pageName = "";
  String portalId = "";
  String scheme = "";
  // String language = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageId'] = this.pageId;
    data['pageName'] = this.pageName;
    data['portalId'] = this.portalId;
    data['scheme'] = this.scheme;
    // data['language'] = this.language;
    return data;
  }
}
