class GameContentRequest {
  String? id;
  String? portalId;

  GameContentRequest({this.id, this.portalId});

  GameContentRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    portalId = json['portalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['portalId'] = this.portalId;
    return data;
  }
}
