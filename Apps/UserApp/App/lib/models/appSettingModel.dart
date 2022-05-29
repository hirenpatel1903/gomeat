class AppSetting {
  int notiId;
  int userId;
  bool sms;
  bool app;
  bool email;
  AppSetting();
  AppSetting.fromJson(Map<String, dynamic> json) {
    notiId = json["noti_id"] != null ? int.parse(json["noti_id"].toString()) : null;
    userId = json["user_id"] != null ? int.parse(json["user_id"].toString()) : null;
    sms = json["sms"] != null ? json["sms"] == 1 : null;
    app = json["app"] != null ? json["app"] == 1 : null;
    email = json["email"] != null ? json["email"] == 1 : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "noti_id": notiId,
      "user_id": userId,
      "sms": sms,
      "app": app,
      "email": email,
    };
  }
}
