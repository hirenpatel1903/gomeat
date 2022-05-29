class City {
  int cityId;
  String cityName;
  City();

  City.fromJson(Map<String, dynamic> json) {
    try {
      cityId = json['city_id'] != null ? int.parse(json['city_id'].toString()) : null;
      cityName = json['city_name'] != null ? json['city_name'] : null;
    } catch (e) {
      print("Exception - cityModel.dart - City.fromJson():" + e.toString());
    }
  }
}
