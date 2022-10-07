import 'dart:convert' as convert;

import 'package:app/constant.dart';
import 'package:common_utils/common_utils.dart';

/// 输出Log工具类
class Log {
  static const String tag = 'DEER-LOG';

  static void init() {
    LogUtil.init(isDebug: !Constant.inProduction);
  }

  static void d(String msg, {String tag = tag}) {
    if (!Constant.inProduction) {
      LogUtil.v(msg, tag: tag);
    }
  }

  static void e(String msg, {String tag = tag}) {
    if (!Constant.inProduction) {
      LogUtil.e(msg, tag: tag);
    }
  }
}
