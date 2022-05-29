class TimeSlot {
  String timeslot;
  bool availibility;
  TimeSlot();

  TimeSlot.fromJson(Map<String, dynamic> json) {
    timeslot = json["timeslot"] != null ? json["timeslot"] : null;
    availibility = json["availibility"] != null ? json["availibility"] == 'available' : null;
  }
}
