import 'package:driver/baseurl/baseurlg.dart';

class OrderHistory {
  dynamic cartId;
  dynamic paymentMethod;
  dynamic paymentStatus;
  dynamic userAddress;
  dynamic orderStatus;
  dynamic storeName;
  dynamic storeLat;
  dynamic storeLng;
  dynamic storeAddress;
  dynamic userLat;
  dynamic userLng;
  dynamic dboyLat;
  dynamic dboyLng;
  dynamic userName;
  dynamic userPhone;
  int remainingPrice;
  dynamic deliveryBoyName;
  dynamic deliveryBoyPhone;
  dynamic deliveryDate;
  dynamic timeSlot;
  dynamic totalItems;
  List<ItemsDetails> items;

  OrderHistory(
      {this.cartId,
      this.paymentMethod,
      this.paymentStatus,
      this.userAddress,
      this.orderStatus,
      this.storeName,
      this.storeLat,
      this.storeLng,
      this.storeAddress,
      this.userLat,
      this.userLng,
      this.dboyLat,
      this.dboyLng,
      this.userName,
      this.userPhone,
      this.remainingPrice,
      this.deliveryBoyName,
      this.deliveryBoyPhone,
      this.deliveryDate,
      this.timeSlot,
      this.totalItems,
      this.items});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    userAddress = json['user_address'];
    orderStatus = '${json['order_status']}'.replaceAll('_', ' ');
    storeName = json['store_name'];
    storeLat = json['store_lat'];
    storeLng = json['store_lng'];
    storeAddress = json['store_address'];
    userLat = json['user_lat'];
    userLng = json['user_lng'];
    dboyLat = json['dboy_lat'];
    dboyLng = json['dboy_lng'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    remainingPrice = json['remaining_price'] != null && json['remaining_price'] != '' ? double.parse(json['remaining_price'].toString()).round() : 0;
    deliveryBoyName = json['delivery_boy_name'];
    deliveryBoyPhone = json['delivery_boy_phone'];
    deliveryDate = json['delivery_date'];
    timeSlot = json['time_slot'];
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new ItemsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['user_address'] = this.userAddress;
    data['order_status'] = this.orderStatus;
    data['store_name'] = this.storeName;
    data['store_lat'] = this.storeLat;
    data['store_lng'] = this.storeLng;
    data['store_address'] = this.storeAddress;
    data['user_lat'] = this.userLat;
    data['user_lng'] = this.userLng;
    data['dboy_lat'] = this.dboyLat;
    data['dboy_lng'] = this.dboyLng;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['remaining_price'] = this.remainingPrice;
    data['delivery_boy_name'] = this.deliveryBoyName;
    data['delivery_boy_phone'] = this.deliveryBoyPhone;
    data['delivery_date'] = this.deliveryDate;
    data['time_slot'] = this.timeSlot;
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsDetails {
  dynamic storeOrderId;
  dynamic productName;
  dynamic varientImage;
  dynamic quantity;
  dynamic unit;
  dynamic varientId;
  dynamic qty;
  int price;
  dynamic totalMrp;
  dynamic orderCartId;
  dynamic orderDate;
  dynamic storeApproval;
  dynamic storeId;
  dynamic description;

  ItemsDetails({this.storeOrderId, this.productName, this.varientImage, this.quantity, this.unit, this.varientId, this.qty, this.price, this.totalMrp, this.orderCartId, this.orderDate, this.storeApproval, this.storeId, this.description});

  ItemsDetails.fromJson(Map<String, dynamic> json) {
    storeOrderId = json['store_order_id'];
    productName = json['product_name'];
    varientImage = '$imagebaseUrl${json['varient_image']}';
    quantity = json['quantity'];
    unit = json['unit'];
    varientId = json['varient_id'];
    qty = json['qty'];
    price = json['price'] != null && json['price'] != '' ? double.parse(json['price'].toString()).round() : 0;
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

// class OrderHistory{
//   dynamic cart_id;
//   dynamic delivery_date;
//   dynamic time_slot;
//   dynamic remaining_price;
//   dynamic order_status;
//   dynamic user_lat;
//   dynamic user_lng;
//   dynamic user_address;
//   dynamic user_name;
//   dynamic user_phone;
//   dynamic store_name;
//
//   OrderHistory(
//       this.cart_id,
//       this.delivery_date,
//       this.time_slot,
//       this.remaining_price,
//       this.order_status,
//       this.user_lat,
//       this.user_lng,
//       this.user_address,
//       this.user_name,
//       this.user_phone,
//       this.store_name);
//
//   factory OrderHistory.fromJson(dynamic json){
//     return OrderHistory(json['cart_id'], json['delivery_date'], json['time_slot'], json['remaining_price'], json['order_status'],
//         json['user_lat'], json['user_lng'], json['user_address'], json['user_name'], json['user_phone'], json['store_name']);
//   }
//
//   @override
//   dynamic toString() {
//     return '{cart_id: $cart_id, delivery_date: $delivery_date, time_slot: $time_slot, remaining_price: $remaining_price, order_status: $order_status, user_lat: $user_lat, user_lng: $user_lng, user_address: $user_address, user_name: $user_name, user_phone: $user_phone, store_name: $store_name}';
//   }
// }