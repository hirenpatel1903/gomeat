class GoogleMapModel {
  int id;
  String mapApiKey;

  GoogleMapModel();

  GoogleMapModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ? int.parse(json['id'].toString()) : null;
      mapApiKey = json['map_api_key'] != null ? json['map_api_key'] : null;
    } catch (e) {
      print("Exception - GoogleMapModelModel.dart - GoogleMapModel.fromJson():" + e.toString());
    }
  }
}
