import 'package:gomeat/models/productModel.dart';

class Cart {
  int discountonmrp = 0;
  int totalPrice = 0;
  int totalMrp = 0;
  int totalItems = 0;
  int totalTax = 0;
  int avgTax = 0;
  List<Product> productList = [];

  Cart();
  Cart.fromJson(Map<String, dynamic> json) {
    try {
      discountonmrp = json["discountonmrp"] != null ? double.parse(json["discountonmrp"].toString()).round() : 0;
      totalPrice = json["total_price"] != null ? double.parse(json["total_price"].toString()).round() : 0;
      totalMrp = json["total_mrp"] != null ? double.parse(json["total_mrp"].toString()).round() : 0;
      totalItems = json["total_items"] != null ? json["total_items"] : 0;
      totalTax = json["total_tax"] != null ? double.parse(json["total_tax"].toString()).round() : 0;
      avgTax = json["avg_tax"] != null ? double.parse(json["avg_tax"].toString()).round() : null;
      productList = json['data'] != null ? List<Product>.from(json["data"].map((x) => Product.fromJson(x))) : [];
    } catch (e) {
      print("Exception - cartModel.dart - Cart.fromJson(): " + e.toString());
    }
  }
}
