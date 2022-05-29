import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/productmodel/storeprodcut.dart';

class StoreAdminProduct {
  dynamic status;
  dynamic message;
  List<StoreProductM> data;

  StoreAdminProduct({this.status, this.message, this.data});

  StoreAdminProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new StoreProductM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreProductM {
  dynamic pId;
  dynamic varientId;
  dynamic stock;
  dynamic storeId;
  dynamic mrp;
  dynamic price;
  dynamic productId;
  dynamic quantity;
  dynamic unit;
  dynamic baseMrp;
  dynamic basePrice;
  dynamic description;
  dynamic varientImage;
  dynamic ean;
  dynamic approved;
  dynamic addedBy;
  dynamic catId;
  dynamic productName;
  dynamic productImage;
  dynamic hide;
  List<Tags> tags = [];
  List<Varients> varients = [];

  StoreProductM({this.pId, this.varientId, this.stock, this.storeId, this.mrp, this.price, this.productId, this.quantity, this.unit, this.baseMrp, this.basePrice, this.description, this.varientImage, this.ean, this.approved, this.addedBy, this.catId, this.productName, this.productImage, this.hide});

  StoreProductM.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    varientId = json['varient_id'];
    stock = json['stock'];
    storeId = json['store_id'];
    mrp = json['mrp'];
    price = json['price'];
    productId = json['product_id'];
    quantity = json['quantity'];
    unit = json['unit'];
    baseMrp = json['base_mrp'];
    basePrice = json['base_price'];
    description = json['description'];
    varientImage = '$imagebaseUrl${json['varient_image']}';
    ean = json['ean'];
    approved = json['approved'];
    addedBy = json['added_by'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productImage = '$imagebaseUrl${json['product_image']}';
    hide = json['hide'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_id'] = this.pId;
    data['varient_id'] = this.varientId;
    data['stock'] = this.stock;
    data['store_id'] = this.storeId;
    data['mrp'] = this.mrp;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['base_mrp'] = this.baseMrp;
    data['base_price'] = this.basePrice;
    data['description'] = this.description;
    data['varient_image'] = this.varientImage;
    data['ean'] = this.ean;
    data['approved'] = this.approved;
    data['added_by'] = this.addedBy;
    data['cat_id'] = this.catId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['hide'] = this.hide;
    return data;
  }
}
