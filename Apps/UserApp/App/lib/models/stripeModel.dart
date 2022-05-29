class StripeMethod {
  String stripeStatus;
  String stripSecret;
  String stripePublishable;
  String stripeMerchantId;

  StripeMethod();

  StripeMethod.fromJson(Map<String, dynamic> json) {
    try {
      stripeStatus = json['stripe_status'] != null ? json['stripe_status'] : null;
      stripSecret = json['stripe_secret'] != null ? json['stripe_secret'] : null;
      stripePublishable = json['stripe_publishable'] != null ? json['stripe_publishable'] : null;
      stripeMerchantId = json['stripe_merchant_id'] != null ? json['stripe_merchant_id'] : null;
    } catch (e) {
      print("Exception - stripeMethodModel.dart - StripeMethod.fromJson():" + e.toString());
    }
  }
}
