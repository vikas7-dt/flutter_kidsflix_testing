class CategoryRequest {
  String? portalId;
  String? language;

  CategoryRequest({this.portalId, this.language});

  CategoryRequest.fromJson(Map<String, dynamic> json) {
    portalId = json['portalId'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portalId'] = this.portalId;
    data['language'] = this.language;
    return data;
  }
}
