class SignMain{
  dynamic status;
  dynamic message;
  SignDataModel data;

  SignMain(this.status, this.message, this.data);

  factory SignMain.fromJson(dynamic json){

    var js = json['data'] as List;
    List<SignDataModel> datajs = [];
    SignDataModel ddModel;
    if(js!=null && js.length>0){
      datajs = js.map((e) => SignDataModel.fromJson(e)).toList();
      ddModel = datajs[0];
    }
    return SignMain(json['status'], json['message'], ddModel);
  }

  @override
  String toString() {
    return '{status: $status, message: $message, data: $data}';
  }
}

class SignDataModel{

  dynamic id;
  dynamic store_name;
  dynamic employee_name;
  dynamic phone_number;
  dynamic store_photo;
  dynamic city;
  dynamic admin_share;
  dynamic device_id;
  dynamic email;
  dynamic password;
  dynamic del_range;
  dynamic lat;
  dynamic lng;
  dynamic address;
  dynamic admin_approval;
  dynamic store_status;
  dynamic store_opening_time;
  dynamic store_closing_time;
  dynamic time_interval;
  dynamic inactive_reason;

  SignDataModel(
      this.id,//store_id
      this.store_name,
      this.employee_name,
      this.phone_number,
      this.store_photo,
      this.city,
      this.admin_share,
      this.device_id,
      this.email,
      this.password,
      this.del_range,
      this.lat,
      this.lng,
      this.address,
      this.admin_approval,
      this.store_status,
      this.store_opening_time,
      this.store_closing_time,
      this.time_interval,
      this.inactive_reason);

  factory SignDataModel.fromJson(dynamic json){
    return SignDataModel(json['id'], json['store_name'], json['employee_name'], json['phone_number'], json['store_photo'], json['city'], json['admin_share'], json['device_id'], json['email'], json['password'], json['del_range'], json['lat'], json['lng'], json['address'], json['admin_approval'], json['store_status'], json['store_opening_time'], json['store_closing_time'], json['time_interval'], json['inactive_reason']);
  }

  @override
  String toString() {
    return '{id: $id, store_name: $store_name, employee_name: $employee_name, phone_number: $phone_number, store_photo: $store_photo, city: $city, admin_share: $admin_share, device_id: $device_id, email: $email, password: $password, del_range: $del_range, lat: $lat, lng: $lng, address: $address, admin_approval: $admin_approval, store_status: $store_status, store_opening_time: $store_opening_time, store_closing_time: $store_closing_time, time_interval: $time_interval, inactive_reason: $inactive_reason}';
  }
}