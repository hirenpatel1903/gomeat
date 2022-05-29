class NotificationModel {
  dynamic status;
  dynamic message;
  List<NotificationData> data;

  NotificationModel({this.status, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return null;
  }
}

class NotificationData {
  dynamic status;
  dynamic message;
  int notId;
  String notTitle;
  String notMessage;
  String image;
  int dBoyId;
  int readByDriver;
  DateTime createdAt;

  NotificationData({this.dBoyId, this.image, this.notId, this.notMessage, this.notTitle});

  NotificationData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    notId = json['not_id'];
    dBoyId = json['dboy_id'];
    readByDriver = json['read_by_driver'];
    notTitle = json['not_title'] != null ? json['not_title'] : null;
    image = json['image'] != null ? json['image'] : null;
    notMessage = json['not_message'] != null ? json['not_message'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dboy_id'] = this.dBoyId;
    data['not_id'] = this.notId;
    data['not_title'] = this.notTitle;
    data['not_message'] = this.notMessage;
    data['image'] = this.image;
    return data;
  }
}
