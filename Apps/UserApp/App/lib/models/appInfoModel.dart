class AppInfo {
  String status;
  String message;
  int lastLoc;
  int phoneNumberLength;
  String appName;
  String appLogo;
  String firebase;
  int countryCode;
  String firebaseIso;
  String sms;
  String currencySign;
  String refertext;
  int totalItems;
  String androidAppLink;
  String paymentCurrency;
  String iosAppLink;
  String imageUrl;
  int wishlistCount;
  double userwallet;
  String userServerKey;
  String storeServerKey;
  String driverServerKey;
  int liveChat;
  AppInfo();
  AppInfo.fromJson(Map<String, dynamic> json) {
    try {
      status = json["status"] != null ? json["status"] : null;
      message = json["message"] != null ? json["message"] : null;
      lastLoc = json["last_loc"] != null ? int.parse(json["last_loc"].toString()) : null;
      phoneNumberLength = json["phone_number_length"] != null ? int.parse(json["phone_number_length"].toString()) : null;
      appName = json["app_name"] != null ? json["app_name"] : null;
      appLogo = json["app_logo"] != null ? json["app_logo"] : null;
      firebase = json["firebase"] != null ? json["firebase"] : null;
      countryCode = json["country_code"] != null ? int.parse(json["country_code"].toString()) : null;
      firebaseIso = json["firebase_iso"] != null ? json["firebase_iso"] : null;
      sms = json["sms"] != null ? json["sms"] : null;
      currencySign = json["currency_sign"] != null ? json["currency_sign"] : null;
      refertext = json["refertext"] != null ? json["refertext"] : null;
      totalItems = json["total_items"] != null ? int.parse(json["total_items"].toString()) : null;
      androidAppLink = json["android_app_link"] != null ? json["android_app_link"] : null;
      paymentCurrency = json["payment_currency"] != null ? json["payment_currency"] : null;
      iosAppLink = json["ios_app_link"] != null ? json["ios_app_link"] : null;
      imageUrl = json["image_url"] != null ? json["image_url"] : null;
      wishlistCount = json["wishlist_count"] != null ? int.parse(json["wishlist_count"].toString()) : null;
      userwallet = json["userwallet"] != null ? double.parse(json["userwallet"].toString()) : null;
      liveChat = json['live_chat'] != null ? int.parse(json['live_chat'].toString()) : null;
      userServerKey = json['user_server_key'] != null ? json['user_server_key'] : null;
      storeServerKey = json['store_server_key'] != null ? json['store_server_key'] : null;
      driverServerKey = json['driver_server_key'] != null ? json['driver_server_key'] : null;
    } catch (e) {
      print("Exception - appInfoModel.dart - AppInfo.fromJson():" + e.toString());
    }
  }
}
