class RegistrationModel {
  dynamic status;
  dynamic message;
  RegistrationDataModel data;

  RegistrationModel(this.status, this.message, this.data);

  factory RegistrationModel.fromJson(dynamic json) {
    RegistrationDataModel dataModel;
    if (json['data'] != null) {
      dataModel = RegistrationDataModel.fromJson(json['data']);
      return RegistrationModel(json['status'], json['message'], dataModel);
    } else {
      return RegistrationModel(json['status'], json['message'], null);
    }
  }

  @override
  String toString() {
    return '{status: $status, message: $message, data: $data}';
  }
}

class RegistrationDataModel {
  dynamic store_id;
  dynamic store_name;
  dynamic employee_name;
  dynamic phone_number;
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

  RegistrationDataModel(this.store_id, this.store_name, this.employee_name, this.phone_number, this.city, this.admin_share, this.device_id, this.email, this.password, this.del_range, this.lat, this.lng, this.address, this.admin_approval);

  factory RegistrationDataModel.fromJson(dynamic json) {
    return RegistrationDataModel(json['store_id'], json['store_name'], json['employee_name'], json['phone_number'], json['city'], json['admin_share'], json['device_id'], json['email'], json['password'], json['del_range'], json['lat'], json['lng'], json['address'], json['admin_approval']);
  }

  @override
  String toString() {
    return '{store_id: $store_id, store_name: $store_name, employee_name: $employee_name, phone_number: $phone_number, city: $city, admin_share: $admin_share, device_id: $device_id, email: $email, password: $password, del_range: $del_range, lat: $lat, lng: $lng, address: $address, admin_approval: $admin_approval}';
  }
}
