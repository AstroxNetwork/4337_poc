import 'package:flutter/foundation.dart';

class Constant {
  const Constant._();

  static const bool inProduction = false;

  static const String data = 'data';
  static const String message = 'msg';
  static const String code = 'code';

  static const String accessToken = 'authorization';
  static const String jwtToken = 'jwtToken';

  // localstorage key
  static final String KEY_ADDED_GUARDIANS = 'added_guardians';
  static final String KEY_GUARDIAN_NAME_MAP = 'guardian_name_map';
}
