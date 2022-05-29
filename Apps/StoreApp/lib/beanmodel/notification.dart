class Notifications {
  dynamic status;
  dynamic message;
  dynamic totalOrders;
  dynamic totalRevenue;
  dynamic pendingOrders;
  List<NotificationData> data;

  Notifications({this.status, this.message, this.totalOrders, this.totalRevenue, this.pendingOrders, this.data});

  Notifications.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalOrders = json['total_orders'];
    totalRevenue = json['total_revenue'];
    pendingOrders = json['pending_orders'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
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

class NotificationData {
  int notId;
  String notTitle;
  String notMessage;
  String image;
  int storeId;

  NotificationData({this.storeId, this.image, this.notId, this.notMessage, this.notTitle});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notId = json['not_id'];
    storeId = json['store_id'];
    notTitle = json['not_title'] != null ? json['not_title'] : null;
    image = json['image'] != null ? json['image'] : null;
    notMessage = json['not_message'] != null ? json['not_message'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['not_id'] = this.notId;
    data['not_title'] = this.notTitle;
    data['not_message'] = this.notMessage;
    data['image'] = this.image;
    return data;
  }
}
