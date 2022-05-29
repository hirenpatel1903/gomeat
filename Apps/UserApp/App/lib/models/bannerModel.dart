class Banner {
  int bannerId;
  String bannerName;
  String bannerImage;
  int storeId;
  int catId;
  String type;
  String title;
  int varientId;
  Banner();

  Banner.fromJson(Map<String, dynamic> json) {
    try {
      bannerId = json["banner_id"] != null ? int.parse(json["banner_id"].toString()) : null;
      bannerName = json["banner_name"] != null ? json["banner_name"] : null;
      bannerImage = json["banner_image"] != null ? json["banner_image"] : null;
      storeId = json["store_id"] != null ? int.parse(json["store_id"].toString()) : null;
      catId = json["cat_id"] != null ? int.parse(json["cat_id"].toString()) : null;
      type = json["type"] != null ? json["type"] : null;
      title = json["title"] != null ? json["title"] : null;
      varientId = json["varient_id"] != null ? int.parse(json["varient_id"].toString()) : null;
    } catch (e) {
      print("Exception - bannerModel.dart - Banner.fromJson():" + e.toString());
    }
  }
}
