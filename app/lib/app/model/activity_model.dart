part of 'data_model.dart';

enum ActivityType { receive, send }

@JsonSerializable()
class ActivityModel extends DataModel {
  const ActivityModel({
    required this.date,
    required this.type,
    required this.address,
    required this.count,
    required this.currency,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  final DateTime date;
  final ActivityType type;
  final String address;
  final double count;
  final String currency;

  @override
  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
