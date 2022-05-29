import 'package:gomeat/models/imageModel.dart';
import 'package:gomeat/models/tagsModel.dart';
import 'package:gomeat/models/varientModel.dart';

class Product {
  int storeId;
  int stock;
  int varientId;
  int productId;
  String productName;
  String productImage;
  String description;
  int price;
  int mrp;
  String varientImage;
  String unit;
  int quantity;
  String type;
  int count;
  List<ImageModel> images;
  List<Varient> varient;
  List<TagsModel> tags;
  int discount;
  bool isFavourite = false;
  int cartQty;
  int rating;
  int ratingCount;
  int userRating;
  int maxPrice;
  String ratingDescription;
  Product();

  Product.fromJson(Map<String, dynamic> json) {
    try {
      storeId = json["store_id"] != null ? int.parse(json["store_id"].toString()) : null;
      stock = json["stock"] != null ? int.parse(json["stock"].toString()) : 0;
      varientId = json["varient_id"] != null ? int.parse(json["varient_id"].toString()) : null;
      productId = json["product_id"] != null ? int.parse(json["product_id"].toString()) : null;
      productName = json["product_name"] != null ? json["product_name"] : null;
      productImage = json["product_image"] != null ? json["product_image"] : null;
      description = json["description"] != null ? json["description"] : null;
       ratingDescription = json['rating_description'] != null ? json['rating_description'] : '';
      price = json["price"] != null ? double.parse(json["price"].toString()).round() : null;
      mrp = json["mrp"] != null ? double.parse(json["mrp"].toString()).round() : null;
      varientImage = json["varient_image"] != null ? json["varient_image"] : null;
      unit = json["unit"] != null ? json["unit"] : null;
      quantity = json["quantity"] != null ? int.parse(json["quantity"].toString()) : 0;
      type = json["type"] != null ? json["type"] : '';
      count = json["count"] != null ? json["count"] : null;
      isFavourite = json['isFavourite'] != null && json['isFavourite'] == 'false' ? false : true;
      cartQty = json['cart_qty'] != null ? int.parse(json['cart_qty'].toString()) : 0;
      rating = json['avgrating'] != null ? double.parse(json['avgrating'].toString()).round() : 0;
      userRating = json['rating'] != null ? double.parse(json['rating'].toString()).round() : 0;
      ratingCount = json['countrating'] != null ? int.parse(json['countrating'].toString()) : 0;
      discount = json['discountper'] != null ? double.parse(json['discountper'].toString()).round() : null;
      maxPrice = json['maxprice'] != null ? double.parse(json['maxprice'].toString()).round() : 0;
      images = json["images"] != null ? List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))) : [];
      varient = json["varients"] != null ? List<Varient>.from(json["varients"].map((x) => Varient.fromJson(x))) : [];
      tags = json["tags"] != null ? List<TagsModel>.from(json["tags"].map((x) => TagsModel.fromJson(x))) : [];
    } catch (e) {
      print("Exception - productModel.dart - Product.fromJson():" + e.toString());
    }
  }
}
