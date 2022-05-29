class LocalNotification {
  String firstName;
  String lastName;
  String senderId;
  String route;
  String chatId;
  String otherGlobalId;
  String userId;
  String fcmToken;
  String title;
  String body;
  String userToken;

  LocalNotification();

  LocalNotification.fromJson(Map<String, dynamic> json) {
    try {
      firstName = json['firstName'] != null ? json['firstName'] : null;
      lastName = json['lastName'] != null ? json['lastName'] : null;
      senderId = json['senderId'] != null ? json['senderId'] : null;
      route = json['route'] != null ? json['route'] : null;
      chatId = json['chatId'] != null ? json['chatId'] : null;
      otherGlobalId = json['otherGlobalId'] != null ? json['otherGlobalId'] : null;
      userId = json['userId'] != null ? json['userId'] : null;
      fcmToken = json['fcmToken'] != null ? json['fcmToken'] : null;
      title = json['title'] != null ? json['title'] : null;
      body = json['body'] != null ? json['body'] : null;
      userToken = json['userToken'] != null ? json['userToken'] : null;
    } catch (e) {
      print("Exception - reminder_model.dart - Reminder.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName != null ? lastName : null,
        'senderId': senderId,
        'route': route,
        'chatId': chatId,
        'otherGlobalId': otherGlobalId,
        'userId': userId,
        'fcmToken': fcmToken,
        'title': title,
        'body': body,
        'userToken': userToken != null ? userToken : null,
      };
}
