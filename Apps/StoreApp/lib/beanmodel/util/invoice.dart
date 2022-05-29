class Invoice {
  dynamic status;
  dynamic message;
  dynamic invoiceNo;
  dynamic number;
  dynamic name;
  dynamic address;
  dynamic city;
  dynamic pincode;
  dynamic paidByWallet;
  dynamic couponDiscount;
  dynamic priceToPay;
  dynamic totalPrice;
  dynamic priceWithoutDelivery;
  dynamic deliveryCharge;
  List<OrderDetails> orderDetails;

  Invoice({this.status, this.message, this.invoiceNo, this.number, this.name, this.address, this.city, this.pincode, this.paidByWallet, this.couponDiscount, this.priceToPay, this.totalPrice, this.priceWithoutDelivery, this.deliveryCharge, this.orderDetails});

  Invoice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    invoiceNo = json['invoice_no'];
    number = json['number'];
    name = json['Name'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    paidByWallet = json['paid_by_wallet'];
    couponDiscount = json['coupon_discount'];
    priceToPay = json['price_to_pay'];
    totalPrice = json['total_price'];
    priceWithoutDelivery = json['price_without_delivery'];
    deliveryCharge = json['delivery_charge'];
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['invoice_no'] = this.invoiceNo;
    data['number'] = this.number;
    data['Name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['paid_by_wallet'] = this.paidByWallet;
    data['coupon_discount'] = this.couponDiscount;
    data['price_to_pay'] = this.priceToPay;
    data['total_price'] = this.totalPrice;
    data['price_without_delivery'] = this.priceWithoutDelivery;
    data['delivery_charge'] = this.deliveryCharge;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
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

  OrderDetails({this.storeOrderId, this.productName, this.varientImage, this.quantity, this.unit, this.varientId, this.qty, this.price, this.totalMrp, this.orderCartId, this.orderDate, this.storeApproval, this.storeId, this.description});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    storeOrderId = json['store_order_id'];
    productName = json['product_name'];
    varientImage = json['varient_image'];
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
