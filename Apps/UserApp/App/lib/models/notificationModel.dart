class NotificationModel {
  int notiId;
  int userId;
  String notiTitle;
  String image;
  String notiMessage;
  int readByUser;
  DateTime createdAt;
  NotificationModel();

  NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      notiId = json["noti_id"] != null ? int.parse(json["noti_id"].toString()) : null;
      userId = json["user_id"] != null ? int.parse(json["user_id"].toString()) : null;
      notiTitle = json["noti_title"] != null ? json["noti_title"] : null;
      image = json["image"] != null && json["image"] != '' && json["image"] != 'N/A' ? json["image"] : null;
      notiMessage = json["noti_message"] != null ? json["noti_message"] : null;
      readByUser = json["read_by_user"] != null ? int.parse(json["read_by_user"].toString()) : null;
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
    } catch (e) {
      print("Exception - notificationModel.dart - NotificationModel.fromJson():" + e.toString());
    }
  }
}
