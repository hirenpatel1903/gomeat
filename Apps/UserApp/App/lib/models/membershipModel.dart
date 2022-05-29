class MembershipModel {
  int planId;
  String image;
  String planName;
  int freeDelivery;
  int reward;
  int instantDelivery;
  String planDescription;
  int days;
  int price;
  int hide;

  MembershipModel();
  MembershipModel.fromJson(Map<String, dynamic> json) {
    try {
      planId = json["plan_id"] != null ? int.parse(json["plan_id"].toString()) : null;
      image = json["image"] != null ? json["image"] : null;
      planName = json["plan_name"] != null ? json["plan_name"] : null;
      freeDelivery = json["free_delivery"] != null ? int.parse(json["free_delivery"].toString()) : null;
      reward = json["reward"] != null ? int.parse(json["reward"].toString()) : null;
      instantDelivery = json["instant_delivery"] != null ? int.parse(json["instant_delivery"].toString()) : null;
      planDescription = json["plan_description"] != null ? json["plan_description"] : null;
      days = json["days"] != null ? int.parse(json["days"].toString()) : null;
      price = json["price"] != null ? int.parse(json["price"].toString()) : null;
      hide = json["hide"] != null ? int.parse(json["hide"].toString()) : null;
    } catch (e) {
      print("Exception - membershipModel.dart - Membership.fromJson():" + e.toString());
    }
  }
}
