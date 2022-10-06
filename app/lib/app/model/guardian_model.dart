import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/generated/json/base/json_field.dart';
import 'package:app/generated/json/guardian_model_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class GuardianModel {

	late String name;
	late String address;
  String? addedDate;

  GuardianModel({
    required this.name,
    required this.address,
    this.addedDate
  });

  factory GuardianModel.fromJson(Map<String, dynamic> json) => $GuardianModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $GuardianModelEntityToJson(this);

  toJSONEncodable() {
    return $GuardianModelEntityToJson(this);
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  bool isExpired() {
    Log.d('addedDate = $addedDate');
    if (addedDate == null) {
      return false;
    }
    if (addedDate!.isEmpty) {
      return false;
    }
    var dateTime = DateTime.now();
    var addedDateTime = DateTime.parse(addedDate!);
    Log.d('dateTime = $dateTime, addedDateTime = $addedDateTime');
    return dateTime.millisecondsSinceEpoch - addedDateTime.millisecondsSinceEpoch > 24 * 60 * 60 * 1000;
  }
}