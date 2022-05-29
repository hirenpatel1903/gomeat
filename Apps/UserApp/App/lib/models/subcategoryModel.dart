class Subcategory {
  int catId;
  String title;
  String slug;
  String url;
  String image;
  int parent;
  int level;
  String description;
  int status;
  int addedBy;
  int taxType;
  String taxName;
  int taxPer;
  int txId;
  int productCount;

  Subcategory();
  Subcategory.fromJson(Map<String, dynamic> json) {
    try {
      catId = json["cat_id"] != null ? int.parse(json["cat_id"].toString()) : null;
      title = json["title"] != null ? json["title"] : null;
      slug = json["slug"] != null ? json["slug"] : null;
      url = json["url"] != null ? json["url"] : null;
      image = json["image"] != null ? json["image"] : null;
      parent = json["parent"] != null ? int.parse(json["parent"].toString()) : null;
      level = json["level"] != null ? int.parse(json["level"].toString()) : null;
      description = json["description"] != null ? json["description"] : null;
      status = json["status"] != null ? int.parse(json["status"].toString()) : null;
      addedBy = json["added_by"] != null ? int.parse(json["added_by"].toString()) : null;
      taxType = json["tax_type"] != null ? int.parse(json["tax_type"].toString()) : null;
      taxName = json["tax_name"] != null ? json["tax_name"] : null;
      taxPer = json["tax_per"] != null ? int.parse(json["tax_per"].toString()) : null;
      txId = json["tx_id"] != null ? int.parse(json["tx_id"].toString()) : null;
      productCount = json['prod_count'] != null ? int.parse(json['prod_count'].toString()) : 0;
    } catch (e) {
      print("Exception - subcategoryModel.dart - Subcategory.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "title": title,
        "slug": slug,
        "url": url,
        "image": image,
        "parent": parent,
        "level": level,
        "description": description,
        "status": status,
        "added_by": addedBy,
        "tax_type": taxType,
        "tax_name": taxName,
        "tax_per": taxPer,
        "tx_id": txId,
      };
}
