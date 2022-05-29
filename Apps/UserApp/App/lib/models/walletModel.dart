class Wallet {
  int walletRechargeHistory;
  int userId;
  String rechargeStatus;
  int amount;
  String paymentGateway;
  String dateOfRecharge;
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String password;
  dynamic rememberToken;
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
  DateTime regDate;
  int appUpdate;
  dynamic facebookId;
  String referralCode;
  int membership;
  DateTime memPlanStart;
  DateTime memPlanExpiry;
  dynamic createdAt;
  DateTime updatedAt;
  String cartId;
  int paidbywallet;

  Wallet();

  Wallet.fromJson(Map<String, dynamic> json) {
    try {
      cartId = json["cart_id"] != null ? json["cart_id"] : null;
      walletRechargeHistory = json["wallet_recharge_history"] != null ? int.parse(json["wallet_recharge_history"].toString()) : null;
      userId = json["user_id"] != null ? int.parse(json["user_id"].toString()) : null;
      rechargeStatus = json["recharge_status"] != null ? json["recharge_status"] : null;
      amount = json["amount"] != null ? double.parse(json["amount"].toString()).round() : null;
      paidbywallet = json["paid_by_wallet"] != null ? double.parse(json["paid_by_wallet"].toString()).round() : null;
      paymentGateway = json["payment_gateway"] != null ? json["payment_gateway"] : null;
      id = json["id"] != null ? int.parse(json["id"].toString()) : null;
      name = json["name"] != null ? json["name"] : null;
      email = json["email"] != null ? json["email"] : null;
      emailVerifiedAt = json["email_verified_at"] != null ? json["email_verified_at"] : null;
      password = json["password"] != null ? json["password"] : null;
      rememberToken = json["remember_token"] != null ? json["remember_token"] : null;
      userPhone = json["user_phone"] != null ? json["user_phone"] : null;
      deviceId = json["device_id"] != null ? json["device_id"] : null;
      userImage = json["user_image"] != null ? json["user_image"] : null;
      userCity = json["user_city"] != null ? int.parse(json["user_city"].toString()) : null;
      userArea = json["user_area"] != null ? int.parse(json["user_area"].toString()) : null;
      otpValue = json["otp_value"] != null ? json["otp_value"] : null;
      status = json["status"] != null ? int.parse(json["status"].toString()) : null;
      wallet = json["wallet"] != null ? double.parse(json["wallet"].toString()).round() : null;
      rewards = json["rewards"] != null ? int.parse(json["rewards"].toString()) : null;
      isVerified = json["is_verified"] != null ? int.parse(json["is_verified"].toString()) : null;
      block = json["block"] != null ? int.parse(json["block"].toString()) : null;
      appUpdate = json["app_update"] != null ? int.parse(json["app_update"].toString()) : null;
      facebookId = json["facebook_id"] != null ? json["facebook_id"] : null;
      referralCode = json["referral_code"] != null ? json["referral_code"] : null;
      membership = json["membership"] != null ? int.parse(json["membership"].toString()) : null;
      regDate = json["reg_date"] != null ? DateTime.parse(json["reg_date"]) : null;
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
      dateOfRecharge = json["date_of_recharge"] != null ? json["date_of_recharge"] : null;
      memPlanStart = json["mem_plan_start"] != null ? DateTime.parse(json["mem_plan_start"]) : null;
      memPlanExpiry = json["mem_plan_expiry"] != null ? DateTime.parse(json["mem_plan_expiry"]) : null;
    } catch (e) {
      print("Exception - walletModel.dart - Wallet.fromJson():" + e.toString());
    }
  }
}
