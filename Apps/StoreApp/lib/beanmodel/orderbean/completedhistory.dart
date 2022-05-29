import 'package:vendor/baseurl/baseurlg.dart';

class CompletedHistory {
  int totalRevenue;
  List<CompletedHistoryOrder> data;

  CompletedHistory({this.totalRevenue, this.data});

  CompletedHistory.fromJson(Map<String, dynamic> json) {
    totalRevenue = json['total_revenue'] != null && json['total_revenue'] != '' ? double.parse(json['total_revenue'].toString()).round() : 0;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new CompletedHistoryOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_revenue'] = this.totalRevenue;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedHistoryOrder {
  dynamic orderStatus;
  dynamic deliveryDate;
  dynamic timeSlot;
  dynamic paymentMethod;
  dynamic paymentStatus;
  dynamic paidByWallet;
  dynamic cartId;
  int price;
  dynamic delCharge;
  dynamic remainingAmount;
  dynamic couponDiscount;
  dynamic dboyName;
  dynamic dboyPhone;
  dynamic userName;
  List<CHOrderItme> data;

  CompletedHistoryOrder({this.orderStatus, this.deliveryDate, this.timeSlot, this.paymentMethod, this.paymentStatus, this.paidByWallet, this.cartId, this.price, this.delCharge, this.remainingAmount, this.couponDiscount, this.dboyName, this.dboyPhone, this.userName, this.data});

  CompletedHistoryOrder.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'];
    deliveryDate = json['delivery_date'];
    timeSlot = json['time_slot'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    paidByWallet = json['paid_by_wallet'];
    cartId = json['cart_id'];
    price = json['price'] != null && json['price'] != '' ? double.parse(json['price'].toString()).round() : 0;
    delCharge = json['del_charge'];
    remainingAmount = json['remaining_amount'];
    couponDiscount = json['coupon_discount'];
    dboyName = json['dboy_name'];
    dboyPhone = json['dboy_phone'];
    userName = json['user_name'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new CHOrderItme.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_status'] = this.orderStatus;
    data['delivery_date'] = this.deliveryDate;
    data['time_slot'] = this.timeSlot;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['paid_by_wallet'] = this.paidByWallet;
    data['cart_id'] = this.cartId;
    data['price'] = this.price;
    data['del_charge'] = this.delCharge;
    data['remaining_amount'] = this.remainingAmount;
    data['coupon_discount'] = this.couponDiscount;
    data['dboy_name'] = this.dboyName;
    data['dboy_phone'] = this.dboyPhone;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CHOrderItme {
  dynamic storeOrderId;
  dynamic productName;
  dynamic varientImage;
  dynamic quantity;
  dynamic unit;
  dynamic varientId;
  dynamic qty;
  dynamic price;
  dynamic totalMrp;
  dynamic orderCartId;
  dynamic orderDate;
  dynamic storeApproval;
  dynamic storeId;
  dynamic description;

  CHOrderItme({this.storeOrderId, this.productName, this.varientImage, this.quantity, this.unit, this.varientId, this.qty, this.price, this.totalMrp, this.orderCartId, this.orderDate, this.storeApproval, this.storeId, this.description});

  CHOrderItme.fromJson(Map<String, dynamic> json) {
    storeOrderId = json['store_order_id'];
    productName = json['product_name'];
    varientImage = '$imagebaseUrl${json['varient_image']}';
    quantity = json['quantity'];
    unit = json['unit'];
    varientId = json['varient_id'];
    qty = json['qty'];
    price = json['price'];
    totalMrp = json['total_mrp'];
    orderCartId = json['order_cart_id'];
    orderDate = json['order_date'];
    storeApproval = json['store_approval'];
    storeId = json['store_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_order_id'] = this.storeOrderId;
    data['product_name'] = this.productName;
    data['varient_image'] = this.varientImage;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['varient_id'] = this.varientId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total_mrp'] = this.totalMrp;
    data['order_cart_id'] = this.orderCartId;
    data['order_date'] = this.orderDate;
    data['store_approval'] = this.storeApproval;
    data['store_id'] = this.storeId;
    data['description'] = this.description;
    return data;
  }
}
