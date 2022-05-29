import 'package:gomeat/models/subcategoryModel.dart';

class Category {
  String title;
  int catId;
  String image;
  int storeId;
  String description;
  int startFrom;
  int subcategoryCount;
  List<Subcategory> subCategoryList = [];
  Category();

  Category.fromJson(Map<String, dynamic> json) {
    try {
      catId = json["cat_id"] != null ? int.parse(json["cat_id"].toString()) : null;
      title = json["title"] != null ? json["title"] : null;
      image = json["image"] != null ? json["image"] : null;
      description = json["description"] != null ? json["description"] : null;
      storeId = json["store_id"] != null ? int.parse(json["store_id"].toString()) : null;
      startFrom = json['stfrom'] != null ? int.parse(json['stfrom'].toString()) : null;
      subcategoryCount = json['subcat_count'] != null ? int.parse(json['subcat_count'].toString()) : 0;
      subCategoryList = json['subcategory'] != null ? new List<Subcategory>.from(json['subcategory'].map((x) => Subcategory.fromJson(x))) : [];
    } catch (e) {
      print("Exception - categoryModel.dart - Category.fromJson():" + e.toString());
    }
  }
}
