enum ActivityType {
  Receive,
  Send,
}

class ActivityModel {
  DateTime date;
  ActivityType type;
  String address;
  double count;
  String currency;

  ActivityModel({
    required this.date,
    required this.type,
    required this.address,
    required this.count,
    required this.currency,
  });

// todo: toJson
// todo: fromJson
// todo: toString
}
