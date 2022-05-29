class CancelReason {
  int resId;
  String reason;

  CancelReason.fromJson(Map<String, dynamic> json) {
    try {
      resId = json['res_id'] != null ? int.parse(json['res_id'].toString()) : null;
      reason = json['reason'] != null ? json['reason'] : null;
    } catch (e) {
      print("Exception - CancelReasonModel.dart - CancelReason.fromJson():" + e.toString());
    }
  }
}
