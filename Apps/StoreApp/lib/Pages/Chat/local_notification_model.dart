class LocalNotification {
  String firstName;
  String lastName;
  String senderId;
  String route;
  String chatId;
  String otherGlobalId;
  int userId;
  String fcmToken;
  String title;
  String body;
  String userToken;
  int storeId;

  LocalNotification();

  LocalNotification.fromJson(Map<String, dynamic> json) {
    try {
      firstName = json['firstName'] != null ? json['firstName'] : null;
      lastName = json['lastName'] != null ? json['lastName'] : null;
      storeId = json['storeId'] != null ? int.parse(json['storeId'].toString()) : null;
      route = json['route'] != null ? json['route'] : null;
      chatId = json['chatId'] != null ? json['chatId'] : null;
      otherGlobalId = json['otherGlobalId'] != null ? json['otherGlobalId'] : null;
      userId = json['userId'] != null ? int.parse(json['userId'].toString()) : null;
      fcmToken = json['userToken'] != null ? json['userToken'] : null;
      title = json['title'] != null ? json['title'] : null;
      body = json['body'] != null ? json['body'] : null;
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
