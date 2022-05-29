class PayStackMethod {
  String paystackStatus;
  String paystackPublicKey;
  String paystackSeckeyKey;
  PayStackMethod();

  PayStackMethod.fromJson(Map<String, dynamic> json) {
    try {
      paystackStatus = json['paystack_status'] != null ? json['paystack_status'] : null;
      paystackPublicKey = json['paystack_public_key'] != null ? json['paystack_public_key'] : null;
      paystackSeckeyKey = json['paystack_secret_key'] != null ? json['paystack_secret_key'] : null;
    } catch (e) {
      print("Exception - payStackMethodModel.dart - PayStackMethod.fromJson():" + e.toString());
    }
  }
}
