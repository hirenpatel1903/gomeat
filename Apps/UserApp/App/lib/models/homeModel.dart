import 'package:gomeat/models/bannerModel.dart';
import 'package:gomeat/models/categoryModel.dart';
import 'package:gomeat/models/productModel.dart';

class HomeModel {
  String status;
  String message;
  List<Banner> bannerlist = [];
  List<Banner> secondBannerList = [];
  List<Category> categoryList = [];
  List<Product> recentSellingProductList = [];
  List<Product> topSellingProductList = [];
  List<Product> whatsnewProductList = [];
  List<Product> dealProductList = [];
  List<Product> spotLightProductList = [];

  HomeModel();

  HomeModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json["status"] != null ? json["status"] : null;
      message = json["message"] != null ? json["message"] : null;
      bannerlist = json['banner'] != null ? List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))) : [];
      secondBannerList = json['second_banner'] != null ? List<Banner>.from(json["second_banner"].map((x) => Banner.fromJson(x))) : [];
      categoryList = json['top_cat'] != null ? List<Category>.from(json["top_cat"].map((x) => Category.fromJson(x))) : [];
      recentSellingProductList = json['recentselling'] != null ? List<Product>.from(json["recentselling"].map((x) => Product.fromJson(x))) : [];
      topSellingProductList = json['topselling'] != null ? List<Product>.from(json["topselling"].map((x) => Product.fromJson(x))) : [];
      whatsnewProductList = json['whatsnew'] != null ? List<Product>.from(json["whatsnew"].map((x) => Product.fromJson(x))) : [];
      dealProductList = json['dealproduct'] != null ? List<Product>.from(json["dealproduct"].map((x) => Product.fromJson(x))) : [];
      spotLightProductList = json['spotlight'] != null ? List<Product>.from(json["spotlight"].map((x) => Product.fromJson(x))) : [];
    } catch (e) {
      print("Exception - homeModel.dart - HomeApiModel.fromJson():" + e.toString());
    }
  }
}
