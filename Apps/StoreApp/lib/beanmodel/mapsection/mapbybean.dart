class MapByKey {
  dynamic status;
  dynamic message;
  MapByKeyData data;

  MapByKey({this.status, this.message, this.data});

  MapByKey.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MapByKeyData.fromJson(json['data']) : null;
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

class MapByKeyData {
  dynamic mapId;
  dynamic mapbox;
  dynamic googleMap;

  MapByKeyData({this.mapId, this.mapbox, this.googleMap});

  MapByKeyData.fromJson(Map<String, dynamic> json) {
    mapId = json['map_id'];
    mapbox = json['mapbox'];
    googleMap = json['google_map'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['map_id'] = this.mapId;
    data['mapbox'] = this.mapbox;
    data['google_map'] = this.googleMap;
    return data;
  }
}