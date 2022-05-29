import 'package:gomeat/models/productModel.dart';

class ProductDetail {
  Product productDetail = new Product();
  List<Product> similarProductList = [];

  ProductDetail();

  ProductDetail.fromJson(Map<String, dynamic> json) {
    try {
      productDetail = json['detail'] != null ? Product.fromJson(json['detail']) : null;
      similarProductList = json['similar_product'] != null ? List<Product>.from(json["similar_product"].map((x) => Product.fromJson(x))) : [];
    } catch (e) {
      print("Exception - productDetailModel.dart - ProductDetail.fromJson():" + e.toString());
    }
  }
}
