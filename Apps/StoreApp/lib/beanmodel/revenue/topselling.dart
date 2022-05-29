// class TopSellingRevenueOrdCount{
//   "": "1",
//   "message": "Top Products Of Store",
//   "": 17,
//   "": 0,
//   "": 5,
//   dynamic status;
//   dynamic message;
//   dynamic total_orders;
//   dynamic total_revenue;
//   dynamic pendingOrders;
//   List<TopSellingItemsR> data;
//
//   TopSellingRevenueOrdCount(this.status, this.message, this.totalOrders,
//       this.totalRevenue, this.pendingOrders, this.data);
//
//
// }
//
// class TopSellingItemsR{
//   dynamic storeId;
//   dynamic productName;
//   dynamic varientId;
//   dynamic varientImage;
//   dynamic quantity;
//   dynamic unit;
//   dynamic description;
//   dynamic count;
//   dynamic totalqty;
//   dynamic revenue;
//
//   TopSellingItemsR(
//       this.storeId,
//       this.productName,
//       this.varientId,
//       this.varientImage,
//       this.quantity,
//       this.unit,
//       this.description,
//       this.count,
//       this.totalqty,
//       this.revenue);
//
//   factory TopSellingItemsR.fromJson(dynamic json){
//     return TopSellingItemsR(json['storeId'], json['productName'], json['varientId'], json['varientImage'], json['quantity'], json['unit'], json['description'], json['count'], json['totalqty'], json['revenue']);
//   }
//
//   @override
//   dynamic toString() {
//     return '{storeId: $storeId, productName: $productName, varientId: $varientId, varientImage: $varientImage, quantity: $quantity, unit: $unit, description: $description, count: $count, totalqty: $totalqty, revenue: $revenue}';
//   }
// }

import 'package:vendor/baseurl/baseurlg.dart';

class TopSellingRevenueOrdCount {
  dynamic status;
  dynamic message;
  dynamic totalOrders;
  int totalRevenue;
  dynamic pendingOrders;
  List<TopSellingItemsR> data;

  TopSellingRevenueOrdCount({this.status, this.message, this.totalOrders, this.totalRevenue, this.pendingOrders, this.data});

  TopSellingRevenueOrdCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalOrders = json['total_orders'];
    totalRevenue = json['total_revenue'] != null && json['total_revenue'] != '' ? double.parse(json['total_revenue'].toString()).round() : 0;
    pendingOrders = json['pending_orders'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new TopSellingItemsR.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total_orders'] = this.totalOrders;
    data['total_revenue'] = this.totalRevenue;
    data['pending_orders'] = this.pendingOrders;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopSellingItemsR {
  dynamic storeId;
  dynamic productName;
  dynamic varientId;
  dynamic varientImage;
  dynamic quantity;
  dynamic unit;
  dynamic description;
  dynamic count;
  dynamic totalqty;
  int revenue;

  TopSellingItemsR({this.storeId, this.productName, this.varientId, this.varientImage, this.quantity, this.unit, this.description, this.count, this.totalqty, this.revenue});

  TopSellingItemsR.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    productName = json['product_name'];
    varientId = json['varient_id'];
    varientImage = '$imagebaseUrl${json['varient_image']}';
    quantity = json['quantity'];
    unit = json['unit'];
    description = json['description'];
    count = json['count'];
    totalqty = json['totalqty'];
    revenue = json['revenue'] != null && json['revenue'] != "" ? double.parse(json['revenue'].toString()).round() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['product_name'] = this.productName;
    data['varient_id'] = this.varientId;
    data['varient_image'] = this.varientImage;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['count'] = this.count;
    data['totalqty'] = this.totalqty;
    data['revenue'] = this.revenue;
    return data;
  }
}
