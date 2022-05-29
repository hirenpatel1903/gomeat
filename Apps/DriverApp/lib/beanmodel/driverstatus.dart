class DriverStatus {
  dynamic status;
  dynamic message;
  dynamic onlineStatus;
  dynamic totalOrders;
  dynamic totalIncentive;
  dynamic receivedIncentive;
  dynamic remainingIncentive;
  dynamic pendingOrders;
  dynamic completedOrders;

  DriverStatus(
      {this.status,
        this.message,
        this.onlineStatus,
        this.totalOrders,
        this.totalIncentive,
        this.receivedIncentive,
        this.remainingIncentive,
        this.pendingOrders,
        this.completedOrders});

  DriverStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    onlineStatus = json['online_status'];
    totalOrders = json['total_orders'];
    totalIncentive = json['total_incentive'];
    receivedIncentive = json['received_incentive'];
    remainingIncentive = json['remaining_incentive'];
    pendingOrders = json['pending_orders'];
    completedOrders = json['completed_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['online_status'] = this.onlineStatus;
    data['total_orders'] = this.totalOrders;
    data['total_incentive'] = this.totalIncentive;
    data['received_incentive'] = this.receivedIncentive;
    data['remaining_incentive'] = this.remainingIncentive;
    data['pending_orders'] = this.pendingOrders;
    data['completed_orders'] = this.completedOrders;
    return data;
  }
}