class IdListModel {
  dynamic status;
  dynamic message;
  List<IdListData> data;

  IdListModel(this.status, this.message, this.data);

  factory IdListModel.fromJson(dynamic json) {
    var tagListJson = json['data'] as List;
    var listD = [];
    if (tagListJson != null) {
      listD = tagListJson.map((e) => IdListData.fromJson(e)).toList();
    }
    return IdListModel(json['status'], json['message'], listD);
  }
}

class IdListData {
  dynamic type_id;
  dynamic name;

  IdListData(this.type_id, this.name);

  factory IdListData.fromJson(dynamic json) {
    return IdListData(json['type_id'], json['name']);
  }

  @override
  String toString() {
    return 'IdListData{type_id: $type_id, name: $name}';
  }
}
