import 'dart:convert';

import 'package:app/constant.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  SharedPreferences get _sp => Get.find<SharedPreferences>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? accessToken = _sp.getString(Constant.accessToken);
    LogUtil.d('`accessToken`: $accessToken', tag: 'AuthInterceptor');
    if (accessToken != null) {
      options.headers[Constant.accessToken] = 'bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (data is String) {
      try {
        _handleMapData(jsonDecode(data));
      } catch (_) {}
    } else if (data is Map) {
      _handleMapData(data);
    }
    super.onResponse(response, handler);
  }

  void _handleMapData(Map data) {
    final jwtToken = data['data']?[Constant.jwtToken];
    if (jwtToken is String && jwtToken.isNotEmpty) {
      LogUtil.w('Setting `accessToken`: $jwtToken', tag: 'AuthInterceptor');
      _sp.setString(Constant.accessToken, jwtToken);
    }
  }
}
