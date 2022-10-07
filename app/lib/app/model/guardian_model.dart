part of 'data_model.dart';

@JsonSerializable()
class GuardianModel extends DataModel {
  const GuardianModel({
    required this.name,
    required this.address,
    this.addedDate,
  });

  final String name;
  final String address;
  final String? addedDate;

  factory GuardianModel.fromJson(Map<String, dynamic> json) =>
      _$GuardianModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GuardianModelToJson(this);

  bool isExpired() {
    LogUtil.d('addedDate = $addedDate');
    if (addedDate == null) {
      return false;
    }
    if (addedDate!.isEmpty) {
      return false;
    }
    var dateTime = DateTime.now();
    var addedDateTime = DateTime.parse(addedDate!);
    LogUtil.d('dateTime = $dateTime, addedDateTime = $addedDateTime');
    return dateTime.millisecondsSinceEpoch -
            addedDateTime.millisecondsSinceEpoch >
        24 * 60 * 60 * 1000;
  }
}
