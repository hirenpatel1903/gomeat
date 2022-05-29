class GoogleMapKey {
  dynamic status;
  dynamic message;
  GoogleMapKeyData data;

  GoogleMapKey({this.status, this.message, this.data});

  GoogleMapKey.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GoogleMapKeyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoogleMapKeyData {
  dynamic id;
  dynamic mapApiKey;

  GoogleMapKeyData({this.id, this.mapApiKey});

  GoogleMapKeyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mapApiKey = json['map_api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['map_api_key'] = this.mapApiKey;
    return data;
  }
}