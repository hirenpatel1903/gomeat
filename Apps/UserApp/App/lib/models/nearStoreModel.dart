class NearStoreModel {
  String phoneNumber;
  int delRange;
  int id;
  String storeName;
  int storeStatus;
  String inactiveReason;
  String lat;
  String lng;
  String storeOpeningTime;
  String storeClosingTime;
  String city;
  int cityId;
  double distance;
  String deviceId;
  NearStoreModel();
  NearStoreModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ? json['id'] : null;
      phoneNumber = json["phone_number"] != null ? json["phone_number"] : null;
      delRange = json["del_range"] != null ? int.parse(json["del_range"].toString()) : null;
      id = json["id"] != null ? int.parse(json["id"].toString()) : null;
      storeName = json["store_name"] != null ? json["store_name"] : null;
      storeStatus = json["store_status"] != null ? int.parse(json["store_status"].toString()) : null;
      inactiveReason = json["inactive_reason"] != null ? json["inactive_reason"] : null;
      lat = json["lat"] != null ? json["lat"] : null;
      lng = json["lng"] != null ? json["lng"] : null;
      storeOpeningTime = json["store_opening_time"] != null ? json["store_opening_time"] : null;
      storeClosingTime = json["store_closing_time"] != null ? json["store_closing_time"] : null;
      city = json["city"] != null ? json["city"] : null;
      cityId = json["city_id"] != null ? int.parse(json["city_id"].toString()) : null;
      deviceId = json["device_id"] != null ? json["device_id"] : null;
      distance = json["distance"] != null ? json["distance"].toDouble() : null;
    } catch (e) {
      print("Exception - nearStoreModel.dart - NearStoreModel.fromJson():" + e.toString());
    }
  }
}
