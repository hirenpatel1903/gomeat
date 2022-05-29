class MapBoxApiKey {
  dynamic status;
  dynamic message;
  MapBoxApiKeyData data;

  MapBoxApiKey({this.status, this.message, this.data});

  MapBoxApiKey.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MapBoxApiKeyData.fromJson(json['data']) : null;
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

class MapBoxApiKeyData {
  dynamic mapId;
  dynamic mapboxApi;

  MapBoxApiKeyData({this.mapId, this.mapboxApi});

  MapBoxApiKeyData.fromJson(Map<String, dynamic> json) {
    mapId = json['map_id'];
    mapboxApi = json['mapbox_api'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['map_id'] = this.mapId;
    data['mapbox_api'] = this.mapboxApi;
    return data;
  }
}