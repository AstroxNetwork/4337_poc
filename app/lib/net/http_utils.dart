import 'dart:convert';

import 'package:app/constant.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/net/ExceptionHandle.dart';
import 'package:app/net/base_entity.dart';
import 'package:app/net/dio_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

class HttpUtils {
  static final HttpUtils _singleton = HttpUtils._();

  static late http.Client _httpClient;

  factory HttpUtils() => _singleton;

  http.Client get httpClient => _httpClient;

  static HttpUtils get instance => HttpUtils();

  HttpUtils._() {
    _httpClient = http.Client();
  }

  Future<dynamic> requestPost<T>(
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? params,
  }) {
    return _post<T>(url, params: params).then<void>((BaseEntity<T> result) {
      if (result.code == 200) {
        onSuccess?.call(result.data);
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _post<T>(String url, {Object? params}) async {
    final String? accessToken = Get.find<SharedPreferences>().getString(Constant.accessToken);
    Map<String, String> headers = {
      Constant.accessToken: 'bearer $accessToken'
    };
    http.Response response =
        await _httpClient.post(Uri.parse(url), body: params, headers: headers);
    try {
      final String data = response.body.toString();

      /// 使用compute条件：数据大于10KB（粗略使用10 * 1024）且当前不是集成测试（后面可能会根据Web环境进行调整）
      /// 主要目的减少不必要的性能开销
      final bool isCompute = data.length > 10 * 1024;
      debugPrint('isCompute:$isCompute');
      final Map<String, dynamic> map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BaseEntity<T>.fromJson(map);
    } catch (e) {
      debugPrint(e.toString());
      return BaseEntity<T>(ExceptionHandle.parse_error, '数据解析错误！', null);
    }
  }

  void _cancelLogPrint(dynamic e, String url) {}

  void _onError(int? code, String msg, NetErrorCallback? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    LogUtil.e('接口请求异常： code: $code, mag: $msg');
    onError?.call(code, msg);
  }
}
