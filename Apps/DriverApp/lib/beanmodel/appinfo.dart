class AppInfoModel {
  dynamic status;
  dynamic message;
  dynamic lastLoc;
  dynamic phoneNumberLength;
  dynamic appName;
  dynamic appLogo;
  dynamic firebase;
  dynamic countryCode;
  dynamic firebaseIso;
  dynamic sms;
  dynamic currencySign;
  dynamic refertext;
  dynamic totalItems;
  dynamic androidAppLink;
  dynamic iosAppLink;
  dynamic paymentCurrency;
  dynamic imageUrl;
  dynamic wishlistCount;
  dynamic userWallet;

  AppInfoModel(
      {this.status,
        this.message,
        this.lastLoc,
        this.phoneNumberLength,
        this.appName,
        this.appLogo,
        this.firebase,
        this.countryCode,
        this.firebaseIso,
        this.sms,
        this.currencySign,
        this.refertext,
        this.totalItems,
      this.androidAppLink,
      this.iosAppLink,
      this.paymentCurrency,
      this.wishlistCount,
      this.userWallet});

  AppInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    lastLoc = json['last_loc'];
    phoneNumberLength = json['phone_number_length'];
    appName = json['app_name'];
    appLogo = json['app_logo'];
    firebase = json['firebase'];
    countryCode = json['country_code'];
    firebaseIso = json['firebase_iso'];
    sms = json['sms'];
    currencySign = json['currency_sign'];
    refertext = json['refertext'];
    totalItems = json['total_items'];
    androidAppLink = json['android_app_link'];
    iosAppLink = json['ios_app_link'];
    paymentCurrency = json['payment_currency'];
    imageUrl = json['image_url'];
    wishlistCount = json['wishlist_count'];
    userWallet = json['userwallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['last_loc'] = this.lastLoc;
    data['phone_number_length'] = this.phoneNumberLength;
    data['app_name'] = this.appName;
    data['app_logo'] = this.appLogo;
    data['firebase'] = this.firebase;
    data['country_code'] = this.countryCode;
    data['firebase_iso'] = this.firebaseIso;
    data['sms'] = this.sms;
    data['currency_sign'] = this.currencySign;
    data['refertext'] = this.refertext;
    data['total_items'] = this.totalItems;
    data['android_app_link'] = this.androidAppLink;
    data['ios_app_link'] = this.iosAppLink;
    data['payment_currency'] = this.paymentCurrency;
    data['image_url'] = this.imageUrl;
    data['wishlist_count'] = this.wishlistCount;
    data['userwallet'] = this.userWallet;
    return data;
  }

  @override
  String toString() {
    return 'AppInfoModel{status: $status, message: $message, lastLoc: $lastLoc, phoneNumberLength: $phoneNumberLength, appName: $appName, appLogo: $appLogo, firebase: $firebase, countryCode: $countryCode, firebaseIso: $firebaseIso, sms: $sms, currencySign: $currencySign, refertext: $refertext, totalItems: $totalItems, androidAppLink: $androidAppLink, iosAppLink: $iosAppLink, paymentCurrency: $paymentCurrency, imageUrl: $imageUrl, wishlistCount: $wishlistCount, userWallet: $userWallet}';
  }
}