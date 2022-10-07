import 'package:app/constant.dart';

class BaseEntity<T> {
  const BaseEntity(this.code, this.message, this.data);

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    return BaseEntity(
      json[Constant.code] as int?,
      json[Constant.message] as String,
      json.containsKey(Constant.data)
          ? _generateOBJ<T>(json[Constant.data] as Object)
          : null,
    );
  }

  final int? code;
  final String message;
  final T? data;

  static T? _generateOBJ<T>(Object json) {
    if (T == String) {
      return json.toString() as T;
    } else if (T == Map) {
      return json as T;
    } else {
      return json as T;
    }
  }
}
