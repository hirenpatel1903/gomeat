import 'package:vendor/Pages/Chat/chat_info.dart';

class MessagesModel {
  int id;
  String userId1;
  String userId2;
  String message;

  String url;
  bool isRead;
  bool isActive;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;
  bool isShowDate = false;

  MessagesModel({this.id, this.userId1, this.userId2, this.message, this.isActive, this.url, this.isRead, this.isDelete, this.createdAt, this.updatedAt});
  static MessagesModel fromJson(Map<String, dynamic> json) => MessagesModel(
        userId1: json['userId1'],
        userId2: json['userId2'],
        message: json['message'],
        isActive: json['isActive'],
        isDelete: json['isDelete'],
        url: json['url'],
        isRead: json['isRead'],
        createdAt: Utils.toDateTime(json['createdAt']),
        updatedAt: Utils.toDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId1': userId1,
        'userId2': userId2,
        'message': message,
        'isDelete': isDelete,
        'url': url,
        'isRead': isRead,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
        'updatedAt': updatedAt,
      };
}
