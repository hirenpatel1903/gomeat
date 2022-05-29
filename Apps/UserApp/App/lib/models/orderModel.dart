import 'package:gomeat/models/productModel.dart';

class Order {
  String userName;
  String deliveryAddress;
  String storeName;
  String storeOwner;
  String storePhone;
  String storeEmail;
  String storeAddress;
  String orderStatus;
  String deliveryDate;
  String timeSlot;
  String paymentMethod;
  String paymentStatus;
  int paidByWallet;
  String cartId;
  int price;
  int deliveryCharge;
  int remPrice;
  int couponDiscount;
  String dboyName;
  String dboyPhone;
  int subTotal;

  int totalPrice;
  int totalProductMrp;
  int priceWithoutDelivery;
  int discountonmrp;
  int totaltaxprice;
  int productCount = 0;
  String orderDate;
  DateTime placingTime;
  DateTime confirmTime;
  DateTime cancelledTime;
  DateTime completedTime;
  DateTime outOfDeliveryTime;
  String esimateTime;
  List<Product> productList = [];
  double currentLat;
  double currentLng;
  double storeLat;
  double storeLng;
  double userLat;
  double userLng;

  Order();

  Order.fromJson(Map<String, dynamic> json) {
    try {
      totaltaxprice = json["total_tax_price"] != null ? double.parse(json["total_tax_price"].toString()).round() : 0;
      discountonmrp = json["discountonmrp"] != null ? double.parse(json["discountonmrp"].toString()).round() : 0;
      userName = json["user_name"] != null ? json["user_name"] : null;
      deliveryAddress = json["delivery_address"] != null ? json["delivery_address"] : null;
      storeName = json["store_name"] != null ? json["store_name"] : null;
      storeOwner = json["store_owner"] != null ? json["store_owner"] : null;
      storePhone = json["store_phone"] != null ? json["store_phone"] : null;
      storeEmail = json["store_email"] != null ? json["store_email"] : null;
      storeAddress = json["store_address"] != null ? json["store_address"] : null;
      orderStatus = json["order_status"] != null ? json["order_status"] : null;
      timeSlot = json["time_slot"] != null ? json["time_slot"] : null;
      paymentMethod = json["payment_method"] != null ? json["payment_method"] : null;
      paymentStatus = json["payment_status"] != null ? json["payment_status"] : null;
      paidByWallet = json["paid_by_wallet"] != null ? double.parse(json["paid_by_wallet"].toString()).round() : 0;
      cartId = json["cart_id"] != null ? json["cart_id"] : null;
      price = json["price"] != null ? double.parse(json["price"].toString()).round() : null;
      deliveryCharge = json["delivery_charge"] != null ? double.parse(json["delivery_charge"].toString()).round() : 0;
      remPrice = json["rem_price"] != null ? double.parse(json["rem_price"].toString()).round() : null;
      couponDiscount = json["coupon_discount"] != null ? double.parse(json["coupon_discount"].toString()).round() : 0;
      dboyName = json["dboy_name"] != null ? json["dboy_name"] : null;
      dboyPhone = json["dboy_phone"] != null ? json["dboy_phone"] : null;
      subTotal = json["sub_total"] != null ? double.parse(json["sub_total"].toString()).round() : null;
      deliveryDate = json["delivery_date"] != null ? json["delivery_date"] : null;
      totalPrice = json["total_price"] != null ? double.parse(json["total_price"].toString()).round() : 0;
      totalProductMrp = json["total_products_mrp"] != null ? double.parse(json["total_products_mrp"].toString()).round() : 0;
      priceWithoutDelivery = json["price_without_delivery"] != null ? double.parse(json["price_without_delivery"].toString()).round() : 0;
      productList = json["data"] != null ? List<Product>.from(json["data"].map((x) => Product.fromJson(x))) : [];
      productCount = json['product_count'] != null ? json['product_count'] : 0;
      placingTime = json['placing_time'] != null ? DateTime.parse(json['placing_time'].toString()) : null;
      confirmTime = json['confirm_time'] != null ? DateTime.parse(json['confirm_time'].toString()) : null;
      outOfDeliveryTime = json['out_for_delivery_time'] != null ? DateTime.parse(json['out_for_delivery_time'].toString()) : null;
      completedTime = json['completed_time'] != null ? DateTime.parse(json['completed_time'].toString()) : null;
      cancelledTime = json['cancelled_time'] != null ? DateTime.parse(json['cancelled_time'].toString()) : null;
      orderDate = json['order_date'] != null ? json['order_date'] : null;
      esimateTime = json['estimated_time'] != null ? json['estimated_time'] : null;
      currentLat = json['current_lat'] != null ? double.parse(json['current_lat'].toString()) : null;
      currentLng = json['current_lng'] != null ? double.parse(json['current_lng'].toString()) : null;
      storeLat = json['store_lat'] != null ? double.parse(json['store_lat'].toString()) : null;
      storeLng = json['store_lng'] != null ? double.parse(json['store_lng'].toString()) : null;
      userLat = json['user_lat'] != null ? double.parse(json['user_lat'].toString()) : null;
      userLng = json['user_lng'] != null ? double.parse(json['user_lng'].toString()) : null;
    } catch (e) {
      print("Exception - orderModel.dart - Order.fromJson" + e.toString());
    }
  }
}
