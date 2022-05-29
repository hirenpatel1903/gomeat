class CategoryListMain{
  dynamic status;
  dynamic message;
  List<CategoryListData> data;

  CategoryListMain(this.status, this.message, this.data);

  factory CategoryListMain.fromJson(dynamic json){
    var js = json['data'] as List;
    List<CategoryListData> jsData;
    if(js!=null && js.length>0){
      jsData = js.map((e) => CategoryListData.fromJson(e)).toList();
    }
    return CategoryListMain(json['status'], json['message'],jsData);
  }

  @override
  String toString() {
    return '{status: $status, message: $message, data: $data}';
  }
}

class CategoryListData{
  dynamic cat_id;
  dynamic title;
  dynamic slug;
  dynamic image;
  dynamic parent;
  dynamic level;
  dynamic description;
  dynamic status;
  dynamic added_by;

  CategoryListData(this.cat_id, this.title, this.slug, this.image, this.parent,
      this.level, this.description, this.status, this.added_by);

  factory CategoryListData.fromJson(dynamic json){
    return CategoryListData(json['cat_id'], json['title'], json['slug'], json['image'], json['parent'], json['level'], json['description'], json['status'], json['added_by']);
  }

  @override
  String toString() {
    return '{cat_id: $cat_id, title: $title, slug: $slug, image: $image, parent: $parent, level: $level, description: $description, status: $status, added_by: $added_by}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryListData &&
          runtimeType == other.runtimeType &&
          '$cat_id' == '${other.cat_id}';

  @override
  int get hashCode => cat_id.hashCode;
}