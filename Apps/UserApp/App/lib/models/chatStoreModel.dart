import 'package:gomeat/models/streamFormatter.dart';

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
      storeId: int.parse(json['storeId'].toString()),
      chatId: json['chatId'],
      userId: int.parse(json['userId'].toString()),
      lastMessageTime: json['lastMessageTime'] != null ? json['lastMessageTime'].toDate() : null,
      lastMessage: json['lastMessage'],
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : null,
      updatedAt: json['updatedAt'] != null ? json['updatedAt'].toDate() : null,
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
        'updatedAt': updatedAt,
        'name': name,
        'userProfileImageUrl': userProfileImageUrl,
        'userFcmToken': userFcmToken
      };
}
