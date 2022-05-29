import 'package:vendor/Pages/Chat/chat_info.dart';

class ChatModel {
  int id;
  String userId1;
  String userId2;
  String chatId;
  bool isDelete;
  bool isActive;
  bool user1Delete;
  bool user2Delete;
  DateTime lastMessageTime;
  DateTime createdAt;
  DateTime updatedAt;

  ChatModel({
    this.id,
    this.userId1,
    this.userId2,
    this.chatId,
    this.isDelete,
    this.isActive,
    this.user1Delete,
    this.user2Delete,
    this.lastMessageTime,
    this.createdAt,
    this.updatedAt,
  });

  static ChatModel fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'],
        userId1: json['userId1'],
        userId2: json['userId2'],
        chatId: json['chatId'],
        user1Delete: json['user1Delete'],
        user2Delete: json['user1Delete'],
        createdAt: Utils.toDateTime(json['createdAt']),
        updatedAt: Utils.toDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId1': userId1,
        'userId2': userId2,
        'chatId': chatId,
        'user1Delete': user1Delete,
        'user2Delete': user2Delete,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
