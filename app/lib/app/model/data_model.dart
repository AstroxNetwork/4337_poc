import 'dart:convert';

import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_model.g.dart';

part 'activity_model.dart';
part 'asset_model.dart';
part 'guardian_model.dart';
part 'user_model.dart';

abstract class DataModel {
  const DataModel();

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return jsonEncode(this);
  }
}
