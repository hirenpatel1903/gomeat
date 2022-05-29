import 'dart:io';

class CurrentUser {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String password;
  String rememberToken;
  String userPhone;
  String deviceId;
  String userImage;
  int userCity;
  int userArea;
  String otpValue;
  int status;
  int wallet;
  int rewards;
  int isVerified;
  int block;
  String regDate;
  int appUpdate;
  String facebookId;
  String referralCode;
  int membership;
  String memPlanStart;
  String memPlanExpiry;
  String createdAt;
  String updatedAt;
  String token;
  String fbId;
  File userImageFile;
  String appleId;
  int cartCount;
  CurrentUser();

  CurrentUser.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ?int.parse( json['id'].toString()) : null;
      name = json['name'] != null ? json['name'] : null;
      email = json['email'] != null ? json['email'] : null;
      emailVerifiedAt = json['email_verified_at'] != null ? json['email_verified_at'] : null;
      password = json['password'] != null ? json['password'] : null;
      rememberToken = json['remember_token'] != null ? json['remember_token'] : null;
      userPhone = json['user_phone'] != null ? json['user_phone'] : null;
      deviceId = json['device_id'] != null ? json['device_id'] : null;
      userImage = json['user_image'] != null && json['user_image'] != 'N/A' ? json['user_image'] : null;
      userCity = json['user_city'] != null ?int.parse( json['user_city'].toString()) : null;
      userArea = json['user_area'] != null ?int.parse( json['user_area'].toString()) : null;
      otpValue = json['otp_value'] != null ? json['otp_value'] : null;
      status = json['status'] != null ?int.parse( json['status'].toString()) : null;
      wallet = json['wallet'] != null ? double.parse(json['wallet'].toString()).round() : null;
      rewards = json['rewards'] != null ?int.parse( json['rewards'].toString()) : null;
      isVerified = json['is_verified'] != null ?int.parse( json['is_verified'].toString()) : null;
      block = json['block'] != null ?int.parse( json['block'].toString()) : null;
      regDate = json['reg_date'] != null ? json['reg_date'] : null;
      appUpdate = json['app_update'] != null ?int.parse( json['app_update'].toString()) : null;
      facebookId = json['facebook_id'] != null ? json['facebook_id'] : null;
      referralCode = json['referral_code'] != null ? json['referral_code'] : null;
      membership = json['membership'] != null ?int.parse( json['membership'].toString()) : null;
      memPlanStart = json['mem_plan_start'] != null ? json['mem_plan_start'] : null;
      memPlanExpiry = json['mem_plan_expiry'] != null ? json['mem_plan_expiry'] : null;
      createdAt = json['created_at'] != null ? json['created_at'] : null;
      updatedAt = json['updated_at'] != null ? json['updated_at'] : null;
      token = json['token'] != null ? json['token'] : null;
      cartCount = json['cart_count'] != null ?int.parse( json['cart_count'].toString()) : 0;
    } catch (e) {
      print("Exception - userModel.dart - CurrentUser.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id != null ? id : null,
        'name': name != null ? name : null,
        'email': email != null ? email : null,
        'email_verified_at': emailVerifiedAt != null ? emailVerifiedAt : null,
        'password': password != null ? password : null,
        'remember_token': rememberToken != null ? rememberToken : null,
        'user_phone': userPhone != null ? userPhone : null,
        'device_id': deviceId != null ? deviceId : null,
        'user_image': userImage != null ? userImage : null,
        'user_city': userCity != null ? userCity : null,
        'user_area': userArea != null ? userArea : null,
        'otp_value': otpValue != null ? otpValue : null,
        'status': status != null ? status : null,
        'wallet': wallet != null ? wallet : null,
        'rewards': rewards != null ? rewards : null,
        'is_verified': isVerified != null ? isVerified : null,
        'block': block != null ? block : null,
        'reg_date': regDate != null ? regDate : null,
        'app_update': appUpdate != null ? appUpdate : null,
        'facebook_id': facebookId != null ? facebookId : null,
        'referral_code': referralCode != null ? referralCode : null,
        'membership': membership != null ? membership : null,
        'mem_plan_start': memPlanStart != null ? memPlanStart : null,
        'mem_plan_expiry': memPlanExpiry != null ? memPlanExpiry : null,
        'created_at': createdAt != null ? createdAt : null,
        'updated_at': updatedAt != null ? updatedAt : null,
        'token': token != null ? token : null,
        'cart_count': cartCount != null ? cartCount : 0
      };
}
