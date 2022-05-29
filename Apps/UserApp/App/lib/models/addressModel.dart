class Address {
  int addressId;
  String type;
  int userId;
  String receiverName;
  String receiverPhone;
  String city;
  String society;
  int cityId;
  int societyId;
  String houseNo;
  String landmark;
  String state;
  String pincode;
  String lat;
  String lng;
  int selectStatus;
  DateTime addedAt;
  DateTime updatedAt;
  double distancee;
  Address();
  Address.fromJson(Map<String, dynamic> json) {
    try {
      addressId = json["address_id"] != null ? int.parse(json["address_id"].toString()) : null;
      type = json["type"] != null ? json["type"] : null;
      userId = json["user_id"] != null ? int.parse(json["user_id"].toString()) : null;
      receiverName = json["receiver_name"] != null ? json["receiver_name"] : null;
      receiverPhone = json["receiver_phone"] != null ? json["receiver_phone"] : null;
      city = json["city"] != null ? json["city"] : null;
      society = json["society"] != null ? json["society"] : null;
      cityId = json["city_id"] != null ? int.parse(json["city_id"].toString()) : null;
      societyId = json["society_id"] != null ? int.parse(json["society_id"].toString()) : null;
      houseNo = json["house_no"] != null ? json["house_no"] : null;
      landmark = json["landmark"] != null ? json["landmark"] : null;
      state = json["state"] != null ? json["state"] : null;
      pincode = json["pincode"] != null ? json["pincode"] : null;
      lat = json["lat"] != null ? json["lat"] : null;
      lng = json["lng"] != null ? json["lng"] : null;
      selectStatus = json["select_status"] != null ? int.parse(json["select_status"].toString()) : null;
      distancee = json["distancee"] != null ? double.parse(json["distancee"].toString()) : null;
      addedAt = json["added_at"] != null ? DateTime.parse(json["added_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
    } catch (e) {
      print("Exception - addressModel.dart - Address.fromJson():" + e.toString());
    }
  }
}
