class RazorpayMethod {
  String razorpayStatus;
  String razorpaySecret;
  String razorpayKey;
  RazorpayMethod();

  RazorpayMethod.fromJson(Map<String, dynamic> json) {
    try {
      razorpayStatus = json['razorpay_status'] != null ? json['razorpay_status'] : null;
      razorpaySecret = json['razorpay_secret'] != null ? json['razorpay_secret'] : null;
      razorpayKey = json['razorpay_key'] != null ? json['razorpay_key'] : null;
    } catch (e) {
      print("Exception - razorpayMethod.dart - RazorpayMethod.fromJson():" + e.toString());
    }
  }
}
