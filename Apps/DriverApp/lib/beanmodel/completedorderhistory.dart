class OrderHistoryCompleted {
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
  dynamic cartId;
  dynamic userName;
  dynamic userPhone;
  int remainingPrice;
  dynamic deliveryBoyName;
  dynamic deliveryBoyPhone;
  dynamic deliveryDate;
  dynamic timeSlot;
  dynamic orderDetails;

  OrderHistoryCompleted(
      {this.userAddress,
      this.orderStatus,
      this.storeName,
      this.storeLat,
      this.storeLng,
      this.storeAddress,
      this.userLat,
      this.userLng,
      this.dboyLat,
      this.dboyLng,
      this.cartId,
      this.userName,
      this.userPhone,
      this.remainingPrice,
      this.deliveryBoyName,
      this.deliveryBoyPhone,
      this.deliveryDate,
      this.timeSlot,
      this.orderDetails});

  OrderHistoryCompleted.fromJson(Map<String, dynamic> json) {
    userAddress = json['user_address'];
    orderStatus = json['order_status'];
    storeName = json['store_name'];
    storeLat = json['store_lat'];
    storeLng = json['store_lng'];
    storeAddress = json['store_address'];
    userLat = json['user_lat'];
    userLng = json['user_lng'];
    dboyLat = json['dboy_lat'];
    dboyLng = json['dboy_lng'];
    cartId = json['cart_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    remainingPrice = json['remaining_price'] != null && json['remaining_price'] != '' ? double.parse(json['remaining_price'].toString()).round() : 0;
    deliveryBoyName = json['delivery_boy_name'];
    deliveryBoyPhone = json['delivery_boy_phone'];
    deliveryDate = json['delivery_date'];
    timeSlot = json['time_slot'];
    orderDetails = json['order_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['cart_id'] = this.cartId;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['remaining_price'] = this.remainingPrice;
    data['delivery_boy_name'] = this.deliveryBoyName;
    data['delivery_boy_phone'] = this.deliveryBoyPhone;
    data['delivery_date'] = this.deliveryDate;
    data['time_slot'] = this.timeSlot;
    data['order_details'] = this.orderDetails;
    return data;
  }
}
