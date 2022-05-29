import 'package:gomeat/models/membershipModel.dart';

class MembershipStatus {
  MembershipModel membershipStatus;
  String status;
  MembershipStatus();
  MembershipStatus.fromJson(Map<String, dynamic> json) {
    try {
      membershipStatus = json['membership_status'] != null ? MembershipModel.fromJson(json['membership_status']) : null;
      status = json["status"] != null ? json["status"] : null;
    } catch (e) {
      print("Exception - membershipStatusModel.dart - MembershipStatus.fromJson():" + e.toString());
    }
  }
}
