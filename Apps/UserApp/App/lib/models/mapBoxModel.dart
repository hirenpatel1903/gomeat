class MapBoxModel {
  int id;
  String mapApiKey;

  MapBoxModel();

  MapBoxModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['map_id'] != null ? int.parse(json['map_id'].toString()) : null;
      mapApiKey = json['mapbox_api'] != null ? json['mapbox_api'] : null;
    } catch (e) {
      print("Exception - MapBoxModelModel.dart - MapBoxModel.fromJson():" + e.toString());
    }
  }
}
