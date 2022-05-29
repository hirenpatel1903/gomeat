class Coupon {
  int couponId;
  String couponName;
  String couponImage;
  String couponCode;
  String couponDescription;
  DateTime startDate;
  DateTime endDate;
  int cartValue;
  int amount;
  String type;
  int usesRestriction;
  int storeId;
  Coupon();
  Coupon.fromJson(Map<String, dynamic> json) {
    try {
      couponId = json["coupon_id"] != null ? int.parse(json["coupon_id"].toString()) : null;
      couponName = json["coupon_name"] != null ? json["coupon_name"] : null;
      couponImage = json["coupon_image"] != null ? json["coupon_image"] : null;
      couponCode = json["coupon_code"] != null ? json["coupon_code"] : null;
      couponDescription = json["coupon_description"] != null ? json["coupon_description"] : null;
      cartValue = json["cart_value"] != null ? int.parse(json["cart_value"].toString()) : null;
      amount = json["amount"] != null ? int.parse(json["amount"].toString()) : null;
      type = json["type"] != null ? json["type"] : null;
      usesRestriction = json["uses_restriction"] != null ? int.parse(json["uses_restriction"].toString()) : null;
      storeId = json["store_id"] != null ? int.parse(json["store_id"].toString()) : null;
      startDate = json["start_date"] != null ? DateTime.parse(json["start_date"]) : null;
      endDate = json["end_date"] != null ? DateTime.parse(json["end_date"]) : null;
    } catch (e) {
      print("Exception - couponModel.dart - Coupon.fromJson():" + e.toString());
    }
  }
}
