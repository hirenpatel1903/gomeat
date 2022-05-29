import 'package:vendor/baseurl/baseurlg.dart';
//
// class StoreProductMain{
//
//   dynamic status;
//   dynamic message;
//   List<StoreProductData> data;
//
//   StoreProductMain(this.status, this.message, this.data);
//
//   factory StoreProductMain.fromJson(dynamic json){
//     var js = json['data'] as List;
//     List<StoreProductData> jdata = [];
//     if(js!=null && js.length>0){
//       jdata = js.map((e) => StoreProductData.fromJson(e)).toList();
//     }
//     return StoreProductMain(json['status'], json['message'], jdata);
//   }
//
//   @override
//   dynamic toString() {
//     return '{status: $status, message: $message, data: $data}';
//   }
// }
//
//
// class StoreProductData{
//
//   dynamic product_id;
//   dynamic cat_id;
//   dynamic product_name;
//   dynamic product_image;
//   dynamic hide;
//   dynamic added_by;
//   dynamic approved;
//   dynamic title;
//   dynamic slug;
//   dynamic image;
//   dynamic parent;
//   dynamic level;
//   dynamic description;
//   dynamic status;
//
//
//   StoreProductData(
//       this.product_id,
//       this.cat_id,
//       this.product_name,
//       this.product_image,
//       this.hide,
//       this.added_by,
//       this.approved,
//       this.title,
//       this.slug,
//       this.image,
//       this.parent,
//       this.level,
//       this.description,
//       this.status);
//
//   factory StoreProductData.fromJson(dynamic json){
//     return StoreProductData(json['product_id'], json['cat_id'], json['product_name'], '$imagebaseUrl${json['product_image']}', json['hide'], json['added_by'], json['approved'], json['title'], json['slug'], '$imagebaseUrl${json['image']}', json['parent'], json['level'], json['description'], json['status']);
//
//   }
//
//   @override
//   dynamic toString() {
//     return '{product_id: $product_id, cat_id: $cat_id, product_name: $product_name, product_image: $product_image, hide: $hide, added_by: $added_by, approved: $approved, title: $title, slug: $slug, image: $image, parent: $parent, level: $level, description: $description, status: $status}';
//   }
// }

class StoreProductMain {
  dynamic status;
  dynamic message;
  List<StoreProductData> data;

  StoreProductMain({this.status, this.message, this.data});

  StoreProductMain.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    var js = json['data'] as List;
    if (js != null && js.length > 0) {
      data = [];
      json['data'].forEach((v) {
        data.add(new StoreProductData.fromJson(v));
      });
    } else {
      data = [];
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

class StoreProductData {
  dynamic productId;
  dynamic catId;
  dynamic productName;
  dynamic productImage;
  dynamic hide;
  dynamic addedBy;
  dynamic approved;
  String type;
  List<Tags> tags;
  List<Varients> varients;

  StoreProductData({this.productId, this.catId, this.productName, this.productImage, this.hide, this.addedBy, this.approved, this.type, this.tags, this.varients});

  StoreProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    catId = json['cat_id'];
    productName = json['product_name'];
    type = json['type'];
    productImage = '$imagebaseUrl${json['product_image']}';
    hide = json['hide'];
    addedBy = json['added_by'];
    approved = json['approved'];
    var jstags = json['tags'] as List;
    if (jstags != null && jstags.length > 0) {
      tags = [];
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    } else {
      tags = [];
    }
    var jsvarients = json['varients'] as List;
    if (jsvarients != null && jsvarients.length > 0) {
      varients = [];
      json['varients'].forEach((v) {
        varients.add(new Varients.fromJson(v));
      });
    } else {
      varients = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['cat_id'] = this.catId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['hide'] = this.hide;
    data['added_by'] = this.addedBy;
    data['approved'] = this.approved;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.varients != null) {
      data['varients'] = this.varients.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  dynamic tagId;
  dynamic productId;
  dynamic tag;

  Tags({this.tagId, this.productId, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    productId = json['product_id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['product_id'] = this.productId;
    data['tag'] = this.tag;
    return data;
  }
}

class Varients {
  dynamic addedBy;
  dynamic varientId;
  dynamic description;
  dynamic price;
  dynamic mrp;
  dynamic varientImage;
  dynamic unit;
  dynamic quantity;
  dynamic dealPrice;
  dynamic validFrom;
  dynamic validTo;
  dynamic ean;

  Varients({this.addedBy, this.varientId, this.description, this.price, this.mrp, this.varientImage, this.unit, this.quantity, this.dealPrice, this.validFrom, this.validTo, this.ean});

  Varients.fromJson(Map<String, dynamic> json) {
    addedBy = json['added_by'];
    varientId = json['varient_id'];
    description = json['description'];
    price = json['price'];
    mrp = json['mrp'];
    varientImage = '$imagebaseUrl${json['varient_image']}';
    unit = json['unit'];
    quantity = json['quantity'];
    dealPrice = json['deal_price'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    ean = json['ean'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['added_by'] = this.addedBy;
    data['varient_id'] = this.varientId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['mrp'] = this.mrp;
    data['varient_image'] = this.varientImage;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['deal_price'] = this.dealPrice;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    data['ean'] = this.ean;
    return data;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Varients && runtimeType == other.runtimeType && '$varientId' == '${other.varientId}';

  @override
  int get hashCode => varientId.hashCode;
}
