class Mapby {
  int id;
  int mapbox;
  int googleMap;
  Mapby();

  Mapby.fromJson(Map<String, dynamic> json) {
    try {
      id = json['map_id'] != null ? int.parse(json['map_id'].toString()) : null;
      mapbox = json['mapbox'] != null ? int.parse(json['mapbox'].toString()) : null;
      googleMap = json['google_map'] != null ? int.parse(json['google_map'].toString()) : null;
    } catch (e) {
      print("Exception - mapByModel.dart - Mapby.fromJson():" + e.toString());
    }
  }
}
