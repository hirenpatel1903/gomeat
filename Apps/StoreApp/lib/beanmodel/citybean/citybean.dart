class CityBeanModel{
  dynamic status;
  dynamic message;
  List<CityDataBean> data;

  CityBeanModel(this.status, this.message, this.data);

  factory CityBeanModel.fromJson(dynamic json){
    var tagListJson = json['data'] as List;
    var listD = [];
    if(tagListJson!=null){
      listD = tagListJson.map((e) => CityDataBean.fromJson(e)).toList();
    }
    return CityBeanModel(json['status'], json['message'], listD);
  }
}

class CityDataBean{
  dynamic city_id;
  dynamic city_name;

  CityDataBean(this.city_id, this.city_name);

  factory CityDataBean.fromJson(dynamic json){
    return CityDataBean(json['city_id'], json['city_name']);
  }

  @override
  String toString() {
    return 'CityDataBean{city_id: $city_id, city_name: $city_name}';
  }
}