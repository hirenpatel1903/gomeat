class TagsModel {
  int id;
  int productId;
  String tag;
  bool isSelected = false;
  TagsModel();
  TagsModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['tag_id'] != null ? int.parse(json['tag_id'].toString()) : null;
      productId = json['product_id'] != null ? int.parse(json['product_id'].toString()) : null;
      tag = json['tag'] != null ? json['tag'] : null;
    } catch (e) {
      print("Exception - TagsModelModel.dart - TagsModel.fromJson():" + e.toString());
    }
  }
}
