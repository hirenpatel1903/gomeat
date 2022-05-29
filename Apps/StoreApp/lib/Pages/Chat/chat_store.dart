import 'package:vendor/Pages/Chat/date_formatter.dart';
import 'package:vendor/Pages/Chat/stream_formatter.dart';

class ChatStore {
  int storeId;
  String chatId;
  int userId;
  DateTime lastMessageTime;
  String lastMessage;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String userProfileImageUrl;
  String userFcmToken;

  ChatStore({this.chatId, this.createdAt, this.lastMessage, this.lastMessageTime, this.storeId, this.updatedAt, this.userId, this.name, this.userProfileImageUrl, this.userFcmToken});

  static ChatStore fromJson(Map<String, dynamic> json) => ChatStore(
      storeId: json['storeId'],
      chatId: json['chatId'],
      userId: json['userId'],
      lastMessageTime: DateFormatter.toDateTime(json['lastMessageTime']),
      lastMessage: json['lastMessage'],
      createdAt: DateFormatter.toDateTime(json['createdAt']),
      updatedAt: DateFormatter.toDateTime(json['updatedAt']),
      name: json['name'],
      userProfileImageUrl: json['userProfileImageUrl'],
      userFcmToken: json['userFcmToken']);

  Map<String, dynamic> toJson() => {
        'storeId': storeId,
        'chatId': chatId,
        'userId': userId,
        'lastMessage': lastMessage,
        'lastMessageTime': StreamFormatter.fromDateTimeToJson(lastMessageTime),
        'createdAt': StreamFormatter.fromDateTimeToJson(createdAt),
        'updatedAt': StreamFormatter.fromDateTimeToJson(updatedAt),
        'name': name,
        'userProfileImageUrl': userProfileImageUrl,
        'userFcmToken': userFcmToken
      };
}
