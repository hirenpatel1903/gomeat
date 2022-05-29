class StoreProfileMain {

  dynamic status;
  dynamic message;
  StoreProfileDataMain data;

  StoreProfileMain(this.status, this.message, this.data);

  factory StoreProfileMain.fromJson(dynamic json){
    if(json['data']!=null){
      var jsd = json['data'] as List;
      StoreProfileDataMain jsData = StoreProfileDataMain.fromJson(jsd[0]);
      return StoreProfileMain(json['status'], json['message'], jsData);
    }else{
      return StoreProfileMain(json['status'], json['message'], null);
    }

  }

  @override
  String toString() {
    return '{status: $status, message: $message, data: $data}';
  }
}

class StoreProfileDataMain {
  dynamic store_name;
  dynamic phone_number;
  dynamic email;
  dynamic store_photo;
  dynamic address;
  dynamic owner_name;
  dynamic password;

  StoreProfileDataMain(this.store_name, this.phone_number, this.email, this.store_photo, this.address, this.owner_name, this.password);

  factory StoreProfileDataMain.fromJson(dynamic json){
    return StoreProfileDataMain(
        json['store_name'], json['phone_number'], json['email'], json['store_photo'],json['address'], json['employee_name'], json['password']);
  }

  @override
  String toString() {
    return '{store_name: $store_name, phone_number: $phone_number, email: $email, store_photo: $store_photo, address: $address, owner_name: $owner_name, password: $password}';
  }
}