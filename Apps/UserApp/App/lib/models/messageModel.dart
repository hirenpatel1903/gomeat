class MessagesModel {
  int id;
  String userId1;
  String userId2;
  String message;
  bool isShowDate = false;

  String url;
  bool isRead;
  bool isActive;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  MessagesModel({this.id, this.userId1, this.userId2, this.message, this.isActive, this.url, this.isRead, this.isDelete, this.createdAt, this.updatedAt});
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId1': userId1,
        'userId2': userId2,
        'message': message,
        'isDelete': isDelete,
        'url': url,
        'isRead': isRead,
        'createdAt': createdAt.toUtc(),
        'updatedAt': updatedAt,
      };

  static MessagesModel fromJson(Map<String, dynamic> json) => MessagesModel(
        userId1: json['userId1'],
        userId2: json['userId2'],
        message: json['message'],
        isActive: json['isActive'],
        isDelete: json['isDelete'],
        url: json['url'],
        isRead: json['isRead'],
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : null,
        updatedAt: json['updatedAt'] != null ? json['updatedAt'].toDate() : null,
      );
}
